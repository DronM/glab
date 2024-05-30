package bnkImpParser

import (
	"strings"
)

type Lexer struct {
	input        []rune
	position     int
	readPosition int
	ch           rune
}

func NewLexer(input string) *Lexer {
	l := &Lexer{input: []rune(input)}
	l.readChar()
	return l
}

func (l *Lexer) readChar() {
	if l.readPosition >= len(l.input) {
		l.ch = 0
	} else {
		l.ch = l.input[l.readPosition]
	}
	l.position = l.readPosition
	l.readPosition += 1
}

func (l *Lexer) NextToken() Token {
	var tok Token

	l.skipWhitespace()

	switch l.ch {
	case '(':
		tok = newToken(TK_LPAREN, l.ch)
	case ')':
		tok = newToken(TK_RPAREN, l.ch)
	case '"':
		tok.Type = TK_STRING
		tok.Literal = l.readString()
	case 0:
		tok.Literal = ""
		tok.Type = TK_EOF
	default:
		if isLetter(l.ch) {
			tok.Literal = l.readIdentifier()
			tok.Type = LookupIdent(tok.Literal)
			return tok
		} else {
			tok = newToken(TK_ILLEGAL, l.ch)
		}
	}
	l.readChar()
	return tok
}

func (l *Lexer) readIdentifier() string {
	position := l.position
	for isLetter(l.ch) {
		l.readChar()
	}
	return string(l.input[position:l.position])
}

func (l *Lexer) readString() string {
	position := l.position + 1
	for {
		l.readChar()
		if l.ch == '"' || l.ch == 0 {
			break
		}
	}
	return string(l.input[position:l.position])
}

func LookupIdent(ident string) TokenType {
	if tok, ok := keywords[strings.ToUpper(ident)]; ok {
		return tok
	}
	// fmt.Println("ident not found:", ident)
	return TK_ILLEGAL
}

func isLetter(ch rune) bool {
	return ('a' <= ch && ch <= 'z' || 'A' <= ch && ch <= 'Z') ||
		(rune('а') <= ch && ch <= rune('я') || rune('А') <= ch && ch <= rune('Я')) ||
		ch == '_'
}

func (l *Lexer) skipWhitespace() {
	for l.ch == ' ' || l.ch == '\t' || l.ch == '\n' || l.ch == '\r' {
		l.readChar()
	}
}
