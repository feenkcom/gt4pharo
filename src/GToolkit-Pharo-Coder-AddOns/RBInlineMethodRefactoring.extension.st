Extension { #name : #RBInlineMethodRefactoring }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBInlineMethodRefactoring >> removeUnnecessaryAssignments [
	| rewriter |
	rewriter := self parseTreeRewriter.
	rewriter replace: '| `@Temps | `@.Stmts1. `var := `var. `@.Stmts2' with: '| `@Temps | `@.Stmts1. `@.Stmts2'.
	rewriter replace: '`var := `var' with: '`var'.
	(rewriter executeTree: sourceParseTree)
		ifTrue: [ sourceParseTree := rewriter tree ]
]
