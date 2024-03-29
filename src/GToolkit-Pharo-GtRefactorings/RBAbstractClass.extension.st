Extension { #name : #RBAbstractClass }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBAbstractClass >> gtRemoveSlotsFromTraits [
	| instVarsToRemove |
	
	instVarsToRemove := self isDefined
		ifTrue: [ | localInstVars instVars |
			localInstVars := self realClass localSlots collect: #name.
			instVars := self realClass instVarNames.
			
			instVars difference: localInstVars ]
		ifFalse: [ #() ].

	self instanceVariableNames: (self instanceVariableNames copyWithoutAll: instVarsToRemove).

	^ self instanceVariableNames
]
