/*
    Copyright PELAB, Linkoping University

    This file is part of Relational Meta-Language (RML).
	http://www.ida.liu.se/~pelab/rml

    RML is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    RML is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Foobar; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

 * Adrian Pop, adrpo@ida.liu.se, http://www.ida.liu.se/~adrpo,
 * SyntaxDocument.java 
 *  - created 2004-12-23
 *  - copyright adrpo, IDA/PELAB
 *  - last modified: 2005-01-18
 *  - syntax hightlighting for RML in JEditorPane :)
 */

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.util.*;
import javax.swing.*;
import javax.swing.text.*;

class SyntaxDocument extends DefaultStyledDocument
{
	private DefaultStyledDocument doc;
	private Element rootElement;

	private boolean multiLineComment;
	private MutableAttributeSet normal;
	private MutableAttributeSet keyword;
	private MutableAttributeSet comment;
	private MutableAttributeSet quote;

	private MutableAttributeSet execution;
	private MutableAttributeSet select;	

	private HashSet keywords;

	private String fontFamily = "Courier New";
	private int fontSize = 11;

	public SyntaxDocument()
	{
		doc = this;
		rootElement = doc.getDefaultRootElement();
		putProperty( DefaultEditorKit.EndOfLineStringProperty, "\n" );

		normal = new SimpleAttributeSet();
		StyleConstants.setForeground(normal, Color.black);
		StyleConstants.setFontFamily(normal, fontFamily);
		StyleConstants.setFontSize(normal, fontSize);

		comment = new SimpleAttributeSet(normal);
		StyleConstants.setForeground(comment, Color.decode("#990000"));
		StyleConstants.setBold(comment, false);
		//StyleConstants.setItalic(comment, false);

		/* 
		 * after datatype and relation #FFCC33
		 * strings 996666
		 */
		keyword = new SimpleAttributeSet(normal);
		StyleConstants.setForeground(keyword, Color.decode("#660099"));
		StyleConstants.setBold(keyword, true);
		
		quote = new SimpleAttributeSet(normal);
		StyleConstants.setForeground(quote, Color.decode("#996666"));
		
		execution = new SimpleAttributeSet(normal);
		StyleConstants.setForeground(execution, Color.red);
		
		select = execution;

		keywords = new HashSet();
		keywords.add( "datatype" );
		keywords.add( "type" );
		keywords.add( "int" );
		keywords.add( "real" );
		keywords.add( "bool" );
		keywords.add( "string" );
		keywords.add( "lvar" );
		keywords.add( "list" );
		keywords.add( "vector" );
		keywords.add( "array" );
		keywords.add( "option" );
		keywords.add( "relation" );
		keywords.add( "rule" );
		keywords.add( "nil" );
		keywords.add( "module" );
		keywords.add( "end" );
		keywords.add( "of" );
		keywords.add( "and" );
		keywords.add( "eqtype" );
		keywords.add( "fail" );
		keywords.add( "val" );
		keywords.add( "let" );
		keywords.add( "not" );
		keywords.add( "with" );
		keywords.add( "withtype" );
		keywords.add( "abstract" );
		keywords.add( "default" );
		keywords.add( "as" );
		keywords.add( "axiom" );
		// modelica keywords
		keywords.add( "package" );
		keywords.add( "match" );
		keywords.add( "case" );
		keywords.add( "if" );
		keywords.add( "then" );
		keywords.add( "else" );
		keywords.add( "when" );
		keywords.add( "for" );
		keywords.add( "loop" );
		keywords.add( "algorithm" );
		keywords.add( "equation" );
		keywords.add( "initial" );
		keywords.add( "parameter" );
		keywords.add( "constant" );
		keywords.add( "record" );
		keywords.add( "uniontype" );
		keywords.add( "block" );
		keywords.add( "connect" );
		keywords.add( "connector" );
		keywords.add( "annotation" );
		keywords.add( "each" );
		keywords.add( "elseif" );
		keywords.add( "elsewhen" );
		keywords.add( "enumeration" );
		keywords.add( "encapsulated" );
		keywords.add( "extends" );
		keywords.add( "within" );
		keywords.add( "extends" );
		keywords.add( "external" );
		keywords.add( "final" );
		keywords.add( "flow" );
		keywords.add( "function" );
		keywords.add( "import" );
		keywords.add( "input" );
		keywords.add( "in" );
		keywords.add( "inner" );
		keywords.add( "outer" );
		keywords.add( "output" );
		keywords.add( "model" );
		keywords.add( "protected" );
		keywords.add( "public" );
		keywords.add( "partial" );
		keywords.add( "redeclare" );
		keywords.add( "replaceable" );
		keywords.add( "local" );
		keywords.add( "list" );
		keywords.add( "option" );
		keywords.add( "fail" );

		/*
		 * AND AS AXIOM DATATYPE DEFAULT END EQTYPE FAIL LET MODULE NOT OF RELATION RULE 
		 * TYPE VAL WITH WITHTYPE
		 */
	}

	/*
	 *  Override to apply syntax highlighting after the document has been updated
	 */
	public void insertString(int offset, String str, AttributeSet a) throws BadLocationException
	{
		if (str.equals("module"))
			str = addMatchingEnd(offset);

		super.insertString(offset, str, a);
		processChangedLines(offset, str.length());
	}

	/*
	 *  Override to apply syntax highlighting after the document has been updated
	 */
	public void remove(int offset, int length) throws BadLocationException
	{
		super.remove(offset, length);
		processChangedLines(offset, 0);
	}

	/*
	 *  Determine how many lines have been changed,
	 *  then apply highlighting to each line
	 */
	public void processChangedLines(int offset, int length)
		throws BadLocationException
	{
		String content = doc.getText(0, doc.getLength());

		//  The lines affected by the latest document update

		int startLine = rootElement.getElementIndex( offset );
		int endLine = rootElement.getElementIndex( offset + length );

		//  Make sure all comment lines prior to the start line are commented
		//  and determine if the start line is still in a multi line comment

		// setMultiLineComment( commentLinesBefore( content, startLine ) );

		//  Do the actual highlighting

		for (int i = startLine; i <= endLine; i++)
		{
			applyHighlighting(content, i);
		}

		//  Resolve highlighting to the next end multi line delimiter

		//if (isMultiLineComment())
		//	commentLinesAfter(content, endLine);
		//else
		//	highlightLinesAfter(content, endLine);
	}

	/*
	 *  Highlight lines when a multi line comment is still 'open'
	 *  (ie. matching end delimiter has not yet been encountered)
	 */
	private boolean commentLinesBefore(String content, int line)
	{
		int offset = rootElement.getElement( line ).getStartOffset();

		//  Start of comment not found, nothing to do

		int startDelimiter = lastIndexOf( content, getStartDelimiter(), offset - 2 );

		if (startDelimiter < 0)
			return false;

		//  Matching start/end of comment found, nothing to do

		int endDelimiter = indexOf( content, getEndDelimiter(), startDelimiter );

		if (endDelimiter < offset & endDelimiter != -1)
			return false;

		//  End of comment not found, highlight the lines

		doc.setCharacterAttributes(startDelimiter, offset - startDelimiter + 1, comment, false);
		return true;
	}

	/*
	 *  Highlight comment lines to matching end delimiter
	 */
	private void commentLinesAfter(String content, int line)
	{
		int offset = rootElement.getElement( line ).getEndOffset();

		//  End of comment not found, nothing to do

		int endDelimiter = indexOf( content, getEndDelimiter(), offset );

		if (endDelimiter < 0)
			return;

		//  Matching start/end of comment found, comment the lines

		int startDelimiter = lastIndexOf( content, getStartDelimiter(), endDelimiter );

		if (startDelimiter < 0 || startDelimiter <= offset)
		{
			doc.setCharacterAttributes(offset, endDelimiter - offset + 1, comment, false);
		}
	}

	/*
	 *  Highlight lines to start or end delimiter
	 */
	private void highlightLinesAfter(String content, int line)
		throws BadLocationException
	{
		int offset = rootElement.getElement( line ).getEndOffset();

		//  Start/End delimiter not found, nothing to do

		int startDelimiter = indexOf( content, getStartDelimiter(), offset );
		int endDelimiter = indexOf( content, getEndDelimiter(), offset );

		if (startDelimiter < 0)
			startDelimiter = content.length();

		if (endDelimiter < 0)
			endDelimiter = content.length();

		int delimiter = Math.min(startDelimiter, endDelimiter);

		if (delimiter < offset)
			return;

		//	Start/End delimiter found, reapply highlighting

		int endLine = rootElement.getElementIndex( delimiter );

		for (int i = line + 1; i < endLine; i++)
		{
			Element branch = rootElement.getElement( i );
			Element leaf = doc.getCharacterElement( branch.getStartOffset() );
			AttributeSet as = leaf.getAttributes();

			if ( as.isEqual(comment) )
				applyHighlighting(content, i);
		}
	}

	/*
	 *  Parse the line to determine the appropriate highlighting
	 */
	private void applyHighlighting(String content, int line)
		throws BadLocationException
	{
		int startOffset = rootElement.getElement( line ).getStartOffset();
		int endOffset = rootElement.getElement( line ).getEndOffset() - 1;

		int lineLength = endOffset - startOffset;
		int contentLength = content.length();

		if (endOffset >= contentLength)
			endOffset = contentLength - 1;

		//  set normal attributes for the line

		doc.setCharacterAttributes(startOffset, lineLength, normal, true);

		//  check for single line comment

		int index = content.indexOf(getSingleLineDelimiter(), startOffset);

		if ( (index > -1) && (index < endOffset) )
		{
			doc.setCharacterAttributes(index, endOffset - index + 1, comment, false);
			endOffset = index - 1;
		}

		//  check for tokens

		checkForTokens(content, startOffset, endOffset);
		
		//  check for comments
		int offset1, offset2, offset;		
		if ((offset1 = startingMultiLineComment(content, startOffset, endOffset)) != -1)
		{
			if ((offset2 = endingMultiLineComment(content, offset1, endOffset)) != -1)
			{
				if (offset1 < offset2)
				{
					 doc.setCharacterAttributes(offset1, offset2 - offset1 + 2, comment, false);
					 return;
				}
			}
			doc.setCharacterAttributes(offset1, endOffset - offset1 + 1, comment, false);
			return;
		}				
		if ((offset2 = endingMultiLineComment(content, startOffset, endOffset)) != -1)
		{
			doc.setCharacterAttributes(startOffset, offset2 - startOffset + 2, comment, false);
			return;
		}			
		if (isMultiLineComment())
		{
			doc.setCharacterAttributes(startOffset, endOffset - startOffset + 1, comment, false);
		}			
	}

	/*
	 *  Does this line contain the start delimiter
	 */
	private int startingMultiLineComment(String content, int startOffset, int endOffset)
		throws BadLocationException
	{
		int index = content.indexOf(getStartDelimiter(), startOffset );
		
		if ( (index < 0) || (index > endOffset) )
			return -1;
		else
		{
			setMultiLineComment( true );
			return index;
		}
	}

	/*
	 *  Does this line contain the end delimiter
	 */
	private int endingMultiLineComment(String content, int startOffset, int endOffset)
		throws BadLocationException
	{
		int index = indexOf( content, getEndDelimiter(), startOffset );

		if ( (index < 0) || (index > endOffset) )
			return -1;
		else
		{
			setMultiLineComment( false );
			return index;
		}
	}

	/*
	 *  We have found a start delimiter
	 *  and are still searching for the end delimiter
	 */
	private boolean isMultiLineComment()
	{
		return multiLineComment;
	}

	private void setMultiLineComment(boolean value)
	{
		multiLineComment = value;
	}

	/*
	 *	Parse the line for tokens to highlight
	 */
	private void checkForTokens(String content, int startOffset, int endOffset)
	{
		while (startOffset <= endOffset)
		{
			//  skip the delimiters to find the start of a new token

			while ( isDelimiter( content.substring(startOffset, startOffset + 1) ) )
			{
				if (startOffset < endOffset)
					startOffset++;
				else
					return;
			}

			//  Extract and process the entire token

			if ( isQuoteDelimiter( content.substring(startOffset, startOffset + 1) ) )
				startOffset = getQuoteToken(content, startOffset, endOffset);
			else
				startOffset = getOtherToken(content, startOffset, endOffset);
		}
	}

	/*
	 *
	 */
	private int getQuoteToken(String content, int startOffset, int endOffset)
	{
		String quoteDelimiter = content.substring(startOffset, startOffset + 1);
		String escapeString = getEscapeString(quoteDelimiter);

		int index;
		int endOfQuote = startOffset;

		//  skip over the escape quotes in this quote

		index = content.indexOf(escapeString, endOfQuote + 1);

		while ( (index > -1) && (index < endOffset) )
		{
			endOfQuote = index + 1;
			index = content.indexOf(escapeString, endOfQuote);
		}

		// now find the matching delimiter

		index = content.indexOf(quoteDelimiter, endOfQuote + 1);

		if ( (index < 0) || (index > endOffset) )
			endOfQuote = endOffset;
		else
			endOfQuote = index;

		doc.setCharacterAttributes(startOffset, endOfQuote - startOffset + 1, quote, false);

		return endOfQuote + 1;
	}

	/*
	 *
	 */
	private int getOtherToken(String content, int startOffset, int endOffset)
	{
		int endOfToken = startOffset + 1;

		while ( endOfToken <= endOffset )
		{
			if ( isDelimiter( content.substring(endOfToken, endOfToken + 1) ) )
				break;

			endOfToken++;
		}

		String token = content.substring(startOffset, endOfToken);

		if ( isKeyword( token ) )
		{
			doc.setCharacterAttributes(startOffset, endOfToken - startOffset, keyword, false);
		}

		return endOfToken + 1;
	}

	/*
	 *  Assume the needle will the found at the start/end of the line
	 */
	private int indexOf(String content, String needle, int offset)
	{
		int index;

		while ( (index = content.indexOf(needle, offset)) != -1 )
		{
			String text = getLine( content, index ).trim();

			if (text.startsWith(needle) || text.endsWith(needle))
				break;
			else
				offset = index + 1;
		}

		return index;
	}

	/*
	 *  Assume the needle will the found at the start/end of the line
	 */
	private int lastIndexOf(String content, String needle, int offset)
	{
		int index;

		while ( (index = content.lastIndexOf(needle, offset)) != -1 )
		{
			String text = getLine( content, index ).trim();

			if (text.startsWith(needle) || text.endsWith(needle))
				break;
			else
				offset = index - 1;
		}

		return index;
	}

	private String getLine(String content, int offset)
	{
		int line = rootElement.getElementIndex( offset );
		Element lineElement = rootElement.getElement( line );
		int start = lineElement.getStartOffset();
		int end = lineElement.getEndOffset();
		return content.substring(start, end - 1);
	}

	/*
	 *  Override for other languages
	 */
	protected boolean isDelimiter(String character)
	{
		String operands = ";:{}()[]+-/%<=>!&|^~*";

		if (Character.isWhitespace( character.charAt(0) ) ||
			operands.indexOf(character) != -1 )
			return true;
		else
			return false;
	}

	/*
	 *  Override for other languages
	 */
	protected boolean isQuoteDelimiter(String character)
	{
		String quoteDelimiters = "\"'";

		if (quoteDelimiters.indexOf(character) < 0)
			return false;
		else
			return true;
	}

	/*
	 *  Override for other languages
	 */
	protected boolean isKeyword(String token)
	{
		return keywords.contains( token );
	}

	/*
	 *  Override for other languages
	 */
	protected String getStartDelimiter()
	{
		return "(*";
	}

	/*
	 *  Override for other languages
	 */
	protected String getEndDelimiter()
	{
		return "*)";
	}

	/*
	 *  Override for other languages
	 */
	protected String getSingleLineDelimiter()
	{
		return "//";
	}

	/*
	 *  Override for other languages
	 */
	protected String getEscapeString(String quoteDelimiter)
	{
		return "\\" + quoteDelimiter;
	}

	/*
	 *
	 */
	protected String addMatchingEnd(int offset) throws BadLocationException
	{
		StringBuffer whiteSpace = new StringBuffer();
		int line = rootElement.getElementIndex( offset );
		int i = rootElement.getElement(line).getStartOffset();

		while (true)
		{
			String temp = doc.getText(i, 1);

			if (temp.equals(" ") || temp.equals("\t"))
			{
				whiteSpace.append(temp);
				i++;
			}
			else
				break;
		}

		return "module" + whiteSpace.toString() + "\t\n" + whiteSpace.toString() + "end";
	}


	public static void main(String a[])
	{

		EditorKit editorKit = new StyledEditorKit()
		{
			public Document createDefaultDocument()
			{
				return new SyntaxDocument();
			}
		};

		final JEditorPane edit = new JEditorPane();
		edit.setEditorKitForContentType("text/rml", editorKit);
		edit.setContentType("text/rml");
//		edit.setEditorKit(new StyledEditorKit());
//		edit.setDocument(new SyntaxDocument());

		JButton button = new JButton("Load absyn.rml");
		button.addActionListener( new ActionListener()
		{
			public void actionPerformed(ActionEvent e)
			{
				try
				{
					FileInputStream fis = new FileInputStream( "c:/dev/modelica/modeq/absyn.rml" );
					edit.read( fis, null );
					edit.requestFocus();
					edit.setCaretPosition(10);
					System.out.println("Caret at:" + edit.getCaretPosition());
				}
				catch(Exception e2) 
				{
					System.err.println(e2);
				}
			}
		});
		JFrame frame = new JFrame("RML Syntax Highlighting");
		frame.getContentPane().add( new JScrollPane(edit) );
		frame.getContentPane().add(button, BorderLayout.SOUTH);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setSize(800,300);
		frame.setVisible(true);
	}
}
