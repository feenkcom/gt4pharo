Class {
	#name : #GtExtractExampleFromSnippetRefactoring,
	#superclass : #GtExtractMethodFromSnippetRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtExtractExampleFromSnippetRefactoring >> moveMethod [
	super moveMethod.
	moveToClasses
		do: [ :cls | 
			| ast |
			ast := (cls methodFor: movedSelector) ast.
			ast addPragma: (RBPragmaNode selector: #gtExample arguments: #()).
			cls compile: ast formattedCode ]
]
