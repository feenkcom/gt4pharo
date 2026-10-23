Extension { #name : #RBRemoveClassChange }

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBRemoveClassChange >> asUndoOperation [
	"Define superclasses before their subclasses and refer to superclasses by name.
	Otherwise, undoing the removal of classes in a hierarchy attaches the restored subclasses
	to the obsolete superclasses instead of the restored ones.
	An already obsolete superclass (removed before this class) has no name to look up, so it is kept as is."

	<gtPharoPatch: #Pharo>
	| classChanges |
	classChanges := changeFactory compositeRefactoryChange.
	(self changeClass allSubclasses
		addFirst: self changeClass;
		yourself)
		do: [ :class | 
			classChanges
				defineClass: [ :aBuilder | 
					aBuilder fillFor: class.
					(class superclass isNil or: [ class superclass isObsolete ])
						ifFalse: [ aBuilder superclassName: class superclass name ] ].
			class class instVarNames
				do: [ :varName | classChanges addInstanceVariable: varName to: class class ].
			class selectors
				do: [ :selector | classChanges compile: (class sourceCodeAt: selector) in: class ].
			class class selectors
				do: [ :selector | classChanges compile: (class class sourceCodeAt: selector) in: class class ] ].
	^ classChanges
]
