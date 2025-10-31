Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Pharo-System' }
CompiledMethod >> ast [
	"return an AST for this method. The AST is cached. see class comment of ASTCache"
	
	"Workaround, see https://github.com/pharo-project/pharo/issues/14871
	We force recompile to make sure the next call creates a correct BC to AST mapping"
	
	 ((self hasLiteral: #runtimeUndeclaredReadInContext:) or: 
	 [self hasLiteral: #runtimeUndeclaredWrite:inContext:]) ifTrue: 
	 	[self isInstalled ifTrue: 
 			[ GtPharoCodeModifier current critical:
 				[ self recompile ] ] ].
	
	^ ASTCache at: self
]
