/**
 * Adrian Pop, adrpo@ida.liu.se, created 2004-11-22
 * Copyright adrpo, IDA/PELAB
 * last modified: 2004-12-23
 */
import javax.swing.JEditorPane;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTabbedPane;
import javax.swing.UIManager;

import javax.swing.JTree;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.TreeSelectionModel;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;

import java.net.URL;
import java.io.FileInputStream;
import java.io.IOException;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.util.*;
import javax.swing.tree.*;
import java.io.*;
import java.net.*;

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.util.*;
import javax.swing.*;
import javax.swing.text.*;


public class RMLDataTree extends JPanel implements TreeSelectionListener
{
    private JEditorPane htmlPane;
	private JTabbedPane fileView;
    private JTree tree;
    private URL helpURL;
	static JFrame frame = null;
    private static boolean DEBUG = false;
 
    public static final int KIND_UNKNOWN  = -1;
    public static final int KIND_VARIABLE = 0;
    public static final int KIND_LIST     = 1;
    public static final int KIND_OPTION   = 2;
    public static final int KIND_LVAR     = 3;
    public static final int KIND_VECTOR   = 4;
    public static final int KIND_ARRAY    = 5;
    public static final int KIND_DATATYPE = 6;
    public static final int KIND_STRING   = 7;    
    public static final int KIND_REAL     = 8;
    public static final int KIND_INT      = 9;
    public static final int KIND_BOOLEAN  = 10;
    public static final int KIND_FUNCTION = 11;    
    public static final int KIND_TUPLE    = 12;       
    public static final int KIND_NORMAL   = 13;    
    
	boolean bServerStop = false;

    //Optionally play with line styles.  Possible values are
    //"Angled" (the default), "Horizontal", and "None".
    private static boolean playWithLineStyle = false;
    private static String lineStyle = "Horizontal";
    
    //Optionally set the look and feel.
    private static boolean useSystemLookAndFeel = true;

	public static SimpleThread listenThread = null;

	public static final String rmlServerHostname = "localhost";
	public static final int rmlServerPort = 9999;
	ServerSocket rmlServer = null;
	String line;
	BufferedReader is;
	PrintStream os;
	Socket clientSocket = null;

	DefaultMutableTreeNode top = null;
	DefaultMutableTreeNode rmlVariables = null; 
	DefaultMutableTreeNode child = null;
	DefaultMutableTreeNode parent = null; 

	DefaultTreeModel treeModel = null;

	LinkedList variableFromRML = null;
	
	static String rmlFilesPrefix = null;

    public RMLDataTree() 
	{
        super(new GridLayout(1,0));

        //Create the nodes.
        top = new DefaultMutableTreeNode("RML Data Viewer");
		treeModel = new DefaultTreeModel(top);

        //Create a tree that allows one selection at a time.
        tree = new JTree(treeModel);
		expandAll(tree);
        tree.getSelectionModel().setSelectionMode(TreeSelectionModel.SINGLE_TREE_SELECTION);
        //Listen for when the selection changes.
        tree.addTreeSelectionListener(this);

        if (playWithLineStyle) 
		{
            if (DEBUG) System.out.println("line style = " + lineStyle);
            tree.putClientProperty("JTree.lineStyle", lineStyle);
        }

        //Create the scroll pane and add the tree to it. 
        JScrollPane treeView = new JScrollPane(tree);
                		
        //Create the HTML viewing pane.
        htmlPane = new JEditorPane();
        htmlPane.setEditable(true);
        initHelp();

        JScrollPane htmlView = new JScrollPane(htmlPane);
		fileView = new JTabbedPane();
		fileView.addTab("Help", null, htmlView, "General Help");
        //Add the scroll panes to a split pane.
        JSplitPane splitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT);
        splitPane.setTopComponent(treeView);
		splitPane.setBottomComponent(fileView);

        Dimension minimumSize = new Dimension(100, 50);
        htmlView.setMinimumSize(minimumSize);
		minimumSize = new Dimension(100, 50);
        treeView.setMinimumSize(minimumSize);
        splitPane.setDividerLocation(200); //XXX: ignored in some releases
                                           //of Swing. bug 4101306
        //workaround for bug 4101306:
        //treeView.setPreferredSize(new Dimension(100, 100)); 

        splitPane.setPreferredSize(new Dimension(700, 600));

        //Add the split pane to this panel.
        add(splitPane);

		listenThread = new SimpleThread("listener");
		listenThread.start();
    }

    /** Required by TreeSelectionListener interface. */
    public void valueChanged(TreeSelectionEvent se) 
	{
        DefaultMutableTreeNode node = (DefaultMutableTreeNode)
                           tree.getLastSelectedPathComponent();

        if (node == null) return;

        Object nodeInfo = node.getUserObject();
		htmlPane = new JEditorPane();
		htmlPane.setEditable(true);
		JScrollPane scrollPane = new JScrollPane(htmlPane);
        if (!node.isRoot()) 
		{
            RMLVariableInfo rmlVariable = (RMLVariableInfo)nodeInfo;
            if (rmlVariable.nKind != KIND_STRING)
            {
            	if (rmlVariable.rmlFile.compareTo("RML") == 0)
            	{
					fileView.addTab("RML", null, scrollPane, "RML predefined type");

					htmlPane.setContentType("text/plain");
            		htmlPane.setText("RML predefined type");
            	}
            	else
            	{
					fileView.addTab(rmlVariable.rmlFile, null, scrollPane, rmlFilesPrefix + rmlVariable.rmlFile);

            		RMLEditorKit editorKit = new RMLEditorKit();
			        htmlPane.setEditorKitForContentType("text/rml", editorKit);
					htmlPane.setContentType("text/rml");
            		/* focus & select the line with the interesting text */
            		//htmlPane.select(10,30);
    				try
					{
						FileInputStream fis = new FileInputStream(rmlFilesPrefix + rmlVariable.rmlFile);
						htmlPane.read( fis, null );
						htmlPane.requestFocus();
						int docLength = htmlPane.getDocument().getLength();
						String text = htmlPane.getDocument().getText(0, 
										htmlPane.getDocument().getLength());
						
						int startline = 0;
						int startcolumn = 0;
						if (rmlVariable.nKind == KIND_VARIABLE)
						{
							startline   = rmlVariable.c_sl;
							startcolumn = rmlVariable.c_sc;
						}
						else
						{
							startline   = rmlVariable.sl;
							startcolumn = rmlVariable.sc;							
						}
						int start = text.indexOf("\n");
						for (int i = 2; i < startline; i++)
						{
							start = text.indexOf("\n", start + 1);
						}
						int posNewLine = text.indexOf("\n", start + 1); 
						String strLine = text.substring(start, posNewLine);
						if (DEBUG) System.out.println(strLine + " size: " + (posNewLine-start));
						/* handle the fact that the damn \t is 8 in the RML parser and here is only 1 */
						int startPosition = 0; int noTabs = 0;
						if (strLine.indexOf("\t") != 0)
						{
							for (int j = 0; j < strLine.length(); j++)
							{
								if (startPosition != startcolumn)
								{
									if (strLine.substring(j,j+1).equals("\t")) 
									{
										startPosition = startPosition + 8; noTabs++;
									}
									else
										startPosition++;
								}
								else break;
							}
							startcolumn = startcolumn - (noTabs*8-noTabs);
						}
						if (DEBUG) System.out.println("Column: " + startcolumn + " Tabs: " + noTabs);
						if (start < docLength)
						{
							htmlPane.setCaretPosition(posNewLine);
							htmlPane.moveCaretPosition(start + startcolumn);
						}
					}
					catch(Exception e) 
					{
						System.err.println(e);
					}
            		//displayURL(rmlFilesPrefix + rmlVariable.rmlFile);          		
    	            if (DEBUG) System.out.print(rmlFilesPrefix + rmlVariable.rmlFile + " \n ");
            	}
            }            
            if (rmlVariable.nKind == KIND_STRING)
            {
				fileView.addTab("String", null, scrollPane, "String");

            	rmlVariable.rmlFile.trim();
            	if ((rmlVariable.rmlFile.startsWith("<html>") || 
            		 rmlVariable.rmlFile.startsWith("<HTML>")) /*&&
            		(rmlVariable.rmlFile.endsWith("</html>") || 
            		 rmlVariable.rmlFile.startsWith("</HTML>"))*/)
            	{
            		if (DEBUG) System.out.println("HTML!");
            		htmlPane.setContentType( "text/html" );
            		htmlPane.setText(rmlVariable.rmlFile);
            	}
            	else
            	{
            		if (DEBUG) System.out.println("TEXT!");
			        htmlPane.setContentType("text/plain");
            		htmlPane.setText(rmlVariable.rmlFile);
            	}
            }
        } 
        else 
        {
            displayURL(helpURL);
        }
		fileView.setSelectedIndex(fileView.getTabCount()-1);
        if (DEBUG) System.out.println(nodeInfo.toString());
    }

    private class RMLVariableInfo 
	{
        int nKind;
    	String rmlName = null;
        String rmlType = null;
        String rmlFile = null; 
        String rmlRelation = null;
		int sl=0,sc=0,el=0,ec=0;
		int r_sl=0,r_sc=0,r_el=0,r_ec=0;
		int c_sl=0,c_sc=0,c_el=0,c_ec=0;		
		int nDepth = 0;

        public RMLVariableInfo(
        		int _nKind,
        		String sName, 
				String sType,		
        		String sFile,
				String sRelation,
				int _sl, 
				int _sc, 
				int _el,
				int _ec,
				int _r_sl, 
				int _r_sc, 
				int _r_el,
				int _r_ec,
				int _c_sl, 
				int _c_sc, 
				int _c_el,
				int _c_ec) 
		{
            nKind = _nKind;
        	rmlName = sName; rmlType = sType; rmlRelation = sRelation;
			sl = _sl; sc = _sc;  el = _el; ec = _ec;
			r_sl = _r_sl; r_sc = _r_sc; r_el = _r_el; r_ec = _r_ec;
			c_sl = _c_sl; c_sc = _c_sc; c_el = _c_el; c_ec = _c_ec;			
			rmlFile = sFile;
			nDepth = -1;
        }
        
        public RMLVariableInfo(
        		int _nKind,
        		String sName, 
				String sType,		
        		String sFile,
				int _sl, 
				int _sc, 
				int _el,
				int _ec,
				int _nDepth) 
		{
            nKind = _nKind;
        	rmlName = sName; rmlType = sType;
			sl = _sl; sc = _sc;  el = _el; ec = _ec;
			nDepth = _nDepth;
			try
			{
				rmlFile = sFile;
			}
			catch (Exception e)
			{
				System.err.println("URL maformed:" + sFile);
			}
            if (rmlFile == null) 
			{
                System.err.println("Couldn't find file: " + sFile);
            }
        }
       

        public String toString() 
		{
        	if (nKind == KIND_VARIABLE)
        	{
	            return (rmlName+" / type: "+ rmlType +" / file: "+
						rmlFile+" / position: "+
						sl+"."+sc+"."+el+"."+ec+" / live range: " +
						r_sl+"."+r_sc+"."+r_el+"."+r_ec);
        	}
            return (rmlName+" / type: "+ rmlType +" / file: "+
					rmlFile+" / position: "+
					sl+"."+sc+"."+el+"."+ec+" / depth: " + nDepth);
        }
    }

    private void initHelp() 
	{
        String s = "RMLDataTreeHelp.html";
        helpURL = RMLDataTree.class.getResource(s);
        if (helpURL == null) 
		{
            System.err.println("Couldn't open help file: " + s);
        } 
		else if (DEBUG) System.out.println("Help URL is " + helpURL);

        displayURL(helpURL);
    }

    private void displayURL(String url) 
	{
    	URL urlFromFile = null;
		try
		{
			urlFromFile = new URL(url);
		}
		catch (Exception e)
		{
			System.err.println("URL maformed:" + url);
		}
        if (urlFromFile == null) 
		{
            System.err.println("Couldn't find file: " + url);
        }	
        try 
		{
            if (urlFromFile != null) 
			{
                htmlPane.setPage(url);
            } 
			else 
			{ //null url
				htmlPane.setText("No file");
                if (DEBUG) System.out.println("Attempted to display a null URL.");
            }
        } 
		catch (IOException e) 
		{
            System.err.println("Attempted to read a bad URL: " + url);
        }
    }

    private void displayURL(URL url) 
	{
        try 
		{
            if (url != null) 
			{
                htmlPane.setPage(url);
            } 
			else 
			{ //null url
				htmlPane.setText("No file");
                if (DEBUG) System.out.println("Attempted to display a null URL.");
            }
        } 
		catch (IOException e) 
		{
            System.err.println("Attempted to read a bad URL: " + url);
        }
    }
    
    /**
     * Create the GUI and show it.  For thread safety,
     * this method should be invoked from the
     * event-dispatching thread.
     */
    private static void createAndShowGUI() 
	{
        if (useSystemLookAndFeel) 
		{
            try 
			{
                UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
            } 
			catch (Exception e) 
			{
                System.err.println("Couldn't use system look and feel.");
            }
        }

        //Make sure we have nice window decorations.
        JFrame.setDefaultLookAndFeelDecorated(true);

        //Create and set up the window.
        frame = new JFrame("RMLDataViewer");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        //Create and set up the content pane.
        RMLDataTree newContentPane = new RMLDataTree();
        newContentPane.setOpaque(true); //content panes must be opaque
        frame.setContentPane(newContentPane);
	
        //Display the window.
        frame.pack();
        frame.setVisible(true);
    }

    public static void main(String[] args) 
	{
        //Schedule a job for the event-dispatching thread:
        //creating and showing this application's GUI.
    	if (args.length == 1) rmlFilesPrefix = args[0];
    	else rmlFilesPrefix = "file:///";    	
        javax.swing.SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                createAndShowGUI();
				//listenThread.start();
            }
        });
    }

	public boolean listen()
	{
		// Try to open a server socket on port rmlServerPort on hostname rmlServerHostname
		// Note that we can't choose a port less than 1023 if we are not
		// privileged users (root) 
		try 
		{
			rmlServer = new ServerSocket();
			rmlServer.bind(new InetSocketAddress(rmlServerHostname, rmlServerPort));
			rmlServer.setSoTimeout(0);			
			if (DEBUG) System.out.println("Listening on :" + rmlServer.getInetAddress().getHostName() + ":" + rmlServerPort); 
		}
		catch (IOException e) 
		{
			System.err.println(e);
			bServerStop = true;
			return false;
		}   

		// Create a socket object from the ServerSocket to listen and accept 
		// connections.
		// Open input and output streams

		try 
		{
			clientSocket = rmlServer.accept();
			if (DEBUG) System.out.println("Client connected - now receiving data");
			boolean bNext = true;
			Stack stack = new Stack();
			DefaultMutableTreeNode node = null;
			int currentDepth = -1;
			RMLVariableInfo var = null; 
			is = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()), 100000);
			os = new PrintStream(clientSocket.getOutputStream());
			/*
			 * first reading the variable (name,type,file,range,clause_range)
			 * then contenst:
			 * depth|vName|vType|vFile|sl.sc.el.ec
			 * false|bool|RML|0.0.0.0
			 * true|bool|RML|0.0.0.0"
			 * number:enumer:DCONSTRUCTOR|TYPE|FILE|%d.%d.%d.%d 
			 * int|int|RML|0.0.0.0
			 * pointer:function (same module)|TYPE|RML|0.0.0.0
			 * %f|real|RML|0.0.0.0
			 * -|string|RML|0.0.0.0 -> <.$STRING_START$>STRING<.$STRING_END$.>
			 * pointer:function (external module)|TYPE|RML|0.0.0.0
			 * TUPLE[slots]|TYPE|RML|0.0.0.0 
			 * VECTOR[SLOTS]|TYPE|RML|0.0.0.0
			 * ARRAY[SLOTS]|TYPE|RML|0.0.0.0 
			 * LIST_START|TYPE||RML|0.0.0.0 -> LIST_END|TYPE|RML|0.0.0.0");
			 * NONE[0]|TYPE|RML|0.0.0.0 
			 * SOME[1]|TYPE|RML|0.0.0.0
			 * DATATYPE[slots]|TYPE|FILE|%d.%d.%d.%d" 
			 * ??UNNAMED??[slots]|TYPE|RML|0.0.0.0
			 * LVAR(UNKNOWN)|RML|0.0.0.0
			 */
			int which = 0;
			bServerStop = false;
			String vName = null, vFile = null, vType = null, vRelation = null;
			int sl = 0, sc = 0, el = 0, ec = 0, r_sl = 0, r_sc = 0, r_el = 0, r_ec = 0;
			int c_sl = 0, c_sc = 0, c_el = 0, c_ec = 0;
			int nKind = -1;
			int nDepth = 0;
			int maxDepth = 0;

			// As long as we receive data, send Ok to the client.
			while (!bServerStop) 
			{
				line = is.readLine(); 
				if (DEBUG) System.out.println("Received:" + line);
				if (line == null) break;
				os.println("K");
				if (line.compareTo("<.$STOP$.>") == 0) 
				{ 
					os.println("STOPPING SERVER!");
					break;
				}				
				if (line.compareTo("<.$STRING_START$.>") == 0) 
				{ 
					// string reading
					if (DEBUG) System.out.println("Reading strings");
					String text = "";
					while (true)
					{
						line = is.readLine(); if (DEBUG) System.out.println("Received:" + line);
						if (line == null) continue;
						else if (line.compareTo("<.$STRING_END$.>") != 0)
							 	text += line + "\n"; /* append to the little boy */
						else 
							{
							    /* remove the last \n shit! */
								text = text.substring(0,text.length()-1);
								break;
							}
						/* os.println("string-reading"); */						
					}
					
					((RMLVariableInfo)((DefaultMutableTreeNode)stack.lastElement()).getUserObject()).rmlFile = text;
					((RMLVariableInfo)((DefaultMutableTreeNode)stack.lastElement()).getUserObject()).nKind = KIND_STRING;
					if (DEBUG) System.out.println("Read string:" + text);
					os.println("string-reading-ended");
				}
				else
				if (which < 7) 
				{
					switch(which)
					{
						case 0: { vName = line; break; }     // var name
						case 1: { vType = line; break; }     // var type						
						case 2: { vFile = line; break; }     // file 
						case 3: { vRelation = line; break; } // relation
						case 4: 
						{ 
							String tmp = null;
							tmp = line.substring(0, line.indexOf("."));
							sl = Integer.valueOf(tmp).intValue(); 
							line = line.substring(line.indexOf(".")+1,line.length());
							tmp = line.substring(0, line.indexOf("."));
							sc = Integer.valueOf(tmp).intValue(); 
							line = line.substring(line.indexOf(".")+1,line.length());
							tmp = line.substring(0, line.indexOf("."));
							el = Integer.valueOf(tmp).intValue(); 
							line = line.substring(line.indexOf(".")+1,line.length());
							tmp = line.substring(0, line.length());
							ec = Integer.valueOf(tmp).intValue(); 
							break; 
						} // range						
						case 5: 
						{ 
							String tmp = null;
							tmp = line.substring(0, line.indexOf("."));
							r_sl = Integer.valueOf(tmp).intValue(); 
							line = line.substring(line.indexOf(".")+1,line.length());
							tmp = line.substring(0, line.indexOf("."));
							r_sc = Integer.valueOf(tmp).intValue(); 
							line = line.substring(line.indexOf(".")+1,line.length());
							tmp = line.substring(0, line.indexOf("."));
							r_el = Integer.valueOf(tmp).intValue(); 
							line = line.substring(line.indexOf(".")+1,line.length());
							tmp = line.substring(0, line.length());
							r_ec = Integer.valueOf(tmp).intValue(); 
							break;  
						} // clause_range
						case 6: 
						{ 
							String tmp = null;
							tmp = line.substring(0, line.indexOf("."));
							c_sl = Integer.valueOf(tmp).intValue(); 
							line = line.substring(line.indexOf(".")+1,line.length());
							tmp = line.substring(0, line.indexOf("."));
							c_sc = Integer.valueOf(tmp).intValue(); 
							line = line.substring(line.indexOf(".")+1,line.length());
							tmp = line.substring(0, line.indexOf("."));
							c_el = Integer.valueOf(tmp).intValue(); 
							line = line.substring(line.indexOf(".")+1,line.length());
							tmp = line.substring(0, line.length());
							c_ec = Integer.valueOf(tmp).intValue(); 
							break;  
						} // clause_range
					}
					which = which + 1;
					if (which == 7)
					{
						// everything's read, build the var, put it in the list
						// "file:///c:/dev/modelica/modeq/"
						/* variableFromRML.addLast( */
						node = new DefaultMutableTreeNode(new RMLVariableInfo(
						  		KIND_VARIABLE,
						  		vName, 
								vType, 
								vFile, 
								vRelation,
								sl,	sc,	el,	ec,
								r_sl, r_sc, r_el, r_ec,
								c_sl, c_sc, c_el, c_ec));
						treeModel.insertNodeInto(node, top, top.getChildCount());
						stack.push(node);
					}
				}
				else
				{ 				
					// parse line here!
					String tmp = null;					
					tmp = line.substring(0, line.indexOf("|"));
					nDepth = Integer.valueOf(tmp).intValue();
					line = line.substring(line.indexOf("|")+1,line.length());					
					String sKind = line.substring(0, line.indexOf("|")+1);
					line = line.substring(line.indexOf("|")+1,line.length());
					vName = line.substring(0, line.indexOf("|"));
					line = line.substring(line.indexOf("|")+1,line.length());
					vType = line.substring(0, line.indexOf("|"));
					line = line.substring(line.indexOf("|")+1,line.length());
					vFile = line.substring(0, line.indexOf("|"));
					line = line.substring(line.indexOf("|")+1,line.length());
					//if (DEBUG) System.out.println(sKind+vName+"|"+vType+"|"+vFile+"|"+line);
					
					tmp = line.substring(0, line.indexOf("."));
					sl = Integer.valueOf(tmp).intValue(); 
					line = line.substring(line.indexOf(".")+1,line.length());
					tmp = line.substring(0, line.indexOf("."));
					sc = Integer.valueOf(tmp).intValue(); 
					line = line.substring(line.indexOf(".")+1,line.length());
					tmp = line.substring(0, line.indexOf("."));
					el = Integer.valueOf(tmp).intValue(); 
					line = line.substring(line.indexOf(".")+1,line.length());
					tmp = line.substring(0, line.length());
					ec = Integer.valueOf(tmp).intValue();
					if (sKind == null) nKind = KIND_NORMAL;
					else
					{
						/*java expects this!
						depth|ty|vName|vType|vFile|sl.sc.el.ec\n
						where ty:
						  st<ring>,
						  da<tatype constructor>,
						  tu<ple>,
						  li<st>,
						  en<enumer>,
						  op<option>,
						  lv<ar>,
						  re<al>,
						  in<t>,
						  bo<olean>
						  fu<nction>
						  ve<ctor>*/
					  if (sKind.compareTo("st|") == 0) nKind = KIND_STRING;
					  if (sKind.compareTo("da|") == 0) nKind = KIND_DATATYPE;
					  if (sKind.compareTo("tu|") == 0) nKind = KIND_TUPLE;
					  if (sKind.compareTo("li|") == 0) nKind = KIND_LIST;
					  if (sKind.compareTo("en|") == 0) nKind = KIND_DATATYPE;
					  if (sKind.compareTo("op|") == 0) nKind = KIND_OPTION;
					  if (sKind.compareTo("lv|") == 0) nKind = KIND_LVAR;
					  if (sKind.compareTo("re|") == 0) nKind = KIND_REAL;
					  if (sKind.compareTo("in|") == 0) nKind = KIND_INT;
					  if (sKind.compareTo("bo|") == 0) nKind = KIND_BOOLEAN;
					  if (sKind.compareTo("fu|") == 0) nKind = KIND_FUNCTION;
					  if (sKind.compareTo("ve|") == 0) nKind = KIND_VECTOR;
					  if (sKind.compareTo("ar|") == 0) nKind = KIND_ARRAY;
					  if (nKind == KIND_NORMAL) nKind = KIND_UNKNOWN; 
					}
					if (nDepth > maxDepth) maxDepth = nDepth;
					// deal with updating the tree model here
					var = new RMLVariableInfo(
							  		nKind,
							  		vName, 
									vType, 
									vFile, 
									sl,	sc,	el,	ec,
									nDepth);	
					node = new DefaultMutableTreeNode(var);			
					if (var.nDepth > currentDepth)
					{
						parent = (DefaultMutableTreeNode)stack.lastElement();
						treeModel.insertNodeInto(node, parent, parent.getChildCount());				
						stack.push(node);
						currentDepth = var.nDepth;
					}
					else if (var.nDepth <= currentDepth)
					{
						while (((RMLVariableInfo)((DefaultMutableTreeNode)stack.lastElement()).getUserObject()).nDepth  
						    >= var.nDepth) stack.pop();
						parent = (DefaultMutableTreeNode)stack.lastElement();
						treeModel.insertNodeInto(node, parent, parent.getChildCount());				
						stack.push(node);
						currentDepth = var.nDepth;
					}					
				}
				/* expandAll(tree); */
			}
			rmlServer.close();
			bServerStop = false;
			/* buildTree(variableFromRML, maxDepth); */		
		}   
		catch (IOException e) 
		{
			System.err.println(e);
			bServerStop = true;
			return false;
		}
		return true;
	}


	//{{{ +expandAll(JTree) : void
	/**
	 * Expand all nodes of a tree.
	 *
	 * @param tree  The tree whose nodes to expand.
	 */
	public static void expandAll(JTree tree)
	{
		expandAll(tree, new TreePath(tree.getModel().getRoot()));
	} //}}}

	//{{{ +collapseAll(JTree) : void
	/**
	 * Collapse all nodes of a tree.
	 *
	 * @param tree  The tree whose nodes to expand.
	 */
	public static void collapseAll(JTree tree)
	{
		TreePath pathToRoot = new TreePath(tree.getModel().getRoot());
		collapseAll(tree, pathToRoot);
		if(!tree.isRootVisible())
			tree.expandPath(pathToRoot);
	} //}}}

	//{{{ +expandAll(JTree, TreePath) : void
	/**
	 * Expand a tree node and all its child nodes recursively.
	 *
	 * @param tree  The tree whose nodes to expand.
	 * @param path  Path to the node to start at.
	 */
	public static void expandAll(JTree tree, TreePath path)
	{
		Object node = path.getLastPathComponent();
		TreeModel model = tree.getModel();
		if(model.isLeaf(node))
			return;
		tree.expandPath(path);
		int num = model.getChildCount(node);
		for(int i = 0; i < num; i++)
			expandAll(tree, path.pathByAddingChild(model.getChild(node, i)));
	} //}}}

	//{{{ +collapseAll(JTree, TreePath) : void
	/**
	 * Collapse a tree node and all its child nodes recursively.
	 *
	 * @param tree  The tree whose nodes to collapse.
	 * @param path  Path to the node to start at.
	 */
	public static void collapseAll(JTree tree, TreePath path)
	{
		Object node = path.getLastPathComponent();
		TreeModel model = tree.getModel();
		if(model.isLeaf(node))
			return;
		int num = model.getChildCount(node);
		for(int i = 0; i < num; i++)
			collapseAll(tree, path.pathByAddingChild(model.getChild(node, i)));
		tree.collapsePath(path);
	} //}}}

	//{{{ +getExpandedPaths(JTree) : TreePath[]
	/** Get a copy of the list of expanded tree paths of a tree. */
	public static TreePath[] getExpandedPaths(JTree tree)
	{
		ArrayList expandedPaths = new ArrayList();
		TreePath rootPath = new TreePath(tree.getModel().getRoot());
		Enumeration enumer = tree.getExpandedDescendants(rootPath);
		if(enumer != null)
			while(enumer.hasMoreElements())
				expandedPaths.add(enumer.nextElement());
		TreePath[] array = new TreePath[expandedPaths.size()];
		expandedPaths.toArray(array);
		return array;
	} //}}}

	//{{{ +setExpandedPaths(JTree, TreePath[]) : void
	/** Expand all the previously remembered expanded paths. */
	public static void setExpandedPaths(JTree tree, TreePath[] expandedPaths)
	{
		if(expandedPaths == null)
			return;
		for(int i = 0; i < expandedPaths.length; ++i)
		{
			TreePath oldPath = expandedPaths[i];
			TreePath newPath = searchPath(tree.getModel(), oldPath);
			if(newPath != null)
				tree.expandPath(newPath);
		}
	} //}}}

	//{{{ +searchPath(TreeModel, TreePath) : TreePath
	/**
	 * Search for a path in the specified tree model, whose nodes have
	 * the same name (compared using <code>equals()</code>)
	 * as the ones specified in the old path.
	 *
	 * @return  a new path for the specified model, or null if no such path
	 *   could be found.
	 */
	public static TreePath searchPath(TreeModel model, TreePath oldPath)
	{
		Object treenode = model.getRoot();
		Object[] oldPathNodes = oldPath.getPath();
		TreePath newPath = new TreePath(treenode);
		for(int i = 0; i < oldPathNodes.length; ++i)
		{
			Object oldPathNode = oldPathNodes[i];
			if(treenode.toString().equals(oldPathNode.toString()))
			{
				if(i == oldPathNodes.length - 1)
					return newPath;
				else
				{
					if(model.isLeaf(treenode))
						return null; // not found
					else
					{
						int count = model.getChildCount(treenode);
						boolean foundChild = false;
						for(int j = 0; j < count; ++j)
						{
							Object child = model.getChild(treenode, j);
							if(child.toString().equals(oldPathNodes[i + 1].toString()))
							{
								newPath = newPath.pathByAddingChild(child);
								treenode = child;
								foundChild = true;
								break;
							}
						}
						if(!foundChild)
							return null; // couldn't find child with same name
					}
				}
			}
		}
		return null;
	} //}}}

	private class SimpleThread extends Thread 
	{
		public SimpleThread(String str) 
		{
			super(str);
			if (DEBUG) System.out.println("Creating thread"+str);
		}
		public void run() 
		{
			while (!bServerStop) 
			{
				if (DEBUG) System.out.println("Calling listen!");
				listen();
			}
			htmlPane.setText("\n!!!!ListenerStopped!!!! - client communication failed - restart!");
		}
	}
	
	public void buildTree(LinkedList list, int depth)
	{
		ListIterator idx = list.listIterator(0);
		DefaultMutableTreeNode parentVariable = new DefaultMutableTreeNode(idx.next());
		treeModel.insertNodeInto(parentVariable, top, top.getChildCount());
		list.remove(0); /* we removed the first which is a variable */
		int currentDepth = -1;
		// deal with updating the tree model here
		idx = list.listIterator(0);
		Stack stack = new Stack();
		stack.push(parentVariable);
		while (idx.hasNext())
		{
			RMLVariableInfo var = (RMLVariableInfo)idx.next();
			DefaultMutableTreeNode node = new DefaultMutableTreeNode(var);			
			if (var.nDepth > currentDepth)
			{
				parent = (DefaultMutableTreeNode)stack.lastElement();
				treeModel.insertNodeInto(node, parent, parent.getChildCount());				
				stack.push(node);
				currentDepth = var.nDepth;
			}
			else if (var.nDepth <= currentDepth)
			{
				while (((RMLVariableInfo)((DefaultMutableTreeNode)stack.lastElement()).getUserObject()).nDepth  
				    >= var.nDepth) stack.pop();
				parent = (DefaultMutableTreeNode)stack.lastElement();
				treeModel.insertNodeInto(node, parent, parent.getChildCount());				
				stack.push(node);
				currentDepth = var.nDepth;
			}
		}
	}
	private class RMLEditorKit extends StyledEditorKit
	{
		public Document createDefaultDocument()
		{
			return new SyntaxDocument();
		}
	};	
}
