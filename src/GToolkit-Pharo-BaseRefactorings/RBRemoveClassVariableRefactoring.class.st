"
I am a refactoring for removing class variables.

My precondition verifies that there is no reference to this class variable.
"
Class {
	#name : #RBRemoveClassVariableRefactoring,
	#superclass : #RBVariableRefactoring,
	#category : #'GToolkit-Pharo-BaseRefactorings'
}

{ #category : #transforming }
RBRemoveClassVariableRefactoring >> basicTransform [
	class removeClassVariable: variableName
]

{ #category : #'gt - extensions' }
RBRemoveClassVariableRefactoring >> gtDescription [
	<return: #String or: #BlRunRopedText>
	
	^ ('Remove' asRopedText glamorousRoundedBackground)
		append: ' class variable ' asRopedText;
		append: variableName asRopedText glamorousRoundedBackground;
		append: ' from ' asRopedText;
		append: class name asRopedText
]

{ #category : #preconditions }
RBRemoveClassVariableRefactoring >> preconditions [

	^ ( RBCondition isMetaclass: class ) not
		& ( RBCondition definesClassVariable: variableName in: class )
		&
			( RBCondition
				withBlock: [ | block |

					block := [ :each |
					( each whichSelectorsReferToClassVariable: variableName ) isEmpty
						ifFalse: [ class realClass
								ifNil: [ self refactoringError: ( '<1s> is referenced.' expandMacrosWith: variableName ) ]
								ifNotNil: [ self
										refactoringError: ( '<1s> is referenced.<n>Browse references?' expandMacrosWith: variableName )
										with: [ self
												openBrowserOn:
													( RBVariableEnvironment referencesToClassVariable: variableName in: class realClass )
											]
									]
							]
					].
					class withAllSubclasses do: block.
					class classSide withAllSubclasses do: block.
					true
					] )
]

{ #category : #transforming }
RBRemoveClassVariableRefactoring >> privateTranform [
	self basicTransform
]

{ #category : #transforming }
RBRemoveClassVariableRefactoring >> transform [
	self basicTransform
]
