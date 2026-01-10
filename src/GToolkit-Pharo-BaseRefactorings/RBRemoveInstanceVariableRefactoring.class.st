"
I am a refactoring for removing instance variables.

My precondition verifies that there is no reference to this instance  variable.
"
Class {
	#name : #RBRemoveInstanceVariableRefactoring,
	#superclass : #RBVariableRefactoring,
	#category : #'GToolkit-Pharo-BaseRefactorings-Refactorings'
}

{ #category : #'instance creation' }
RBRemoveInstanceVariableRefactoring class >> model: aNamespace remove: variable from: class [
	^ self model: aNamespace variable: variable class: class
]

{ #category : #'instance creation' }
RBRemoveInstanceVariableRefactoring class >> remove: variable from: class [
	^ self variable: variable class: class
]

{ #category : #transforming }
RBRemoveInstanceVariableRefactoring >> basicTransform [
	class removeInstanceVariable: variableName
]

{ #category : #'gt - extensions' }
RBRemoveInstanceVariableRefactoring >> gtDescription [
	<return: #String or: #BlRunRopedText>
	
	^ ('Remove' asRopedText glamorousRoundedBackground)
		append: ' instance variable ' asRopedText;
		append: variableName asRopedText glamorousRoundedBackground;
		append: ' from ' asRopedText;
		append: class printString asRopedText
]

{ #category : #'gt - extensions' }
RBRemoveInstanceVariableRefactoring >> gtPreconditions [
	| references |

	references := RBCondition hierarchyOf: class referencesInstanceVariable: variableName.
	references errorMacro: ( '<1s> is referenced.' expandMacrosWith: variableName).

	^ ( RBCondition definesInstanceVariable: variableName asString in: class ) & references not
]

{ #category : #preconditions }
RBRemoveInstanceVariableRefactoring >> preconditions [

	| references |

	references := RBCondition hierarchyOf: class referencesInstanceVariable: variableName.
	class realClass
		ifNil: [ references errorMacro: ( '<1s> is referenced.' expandMacrosWith: variableName ) ]
		ifNotNil: [ references
				errorMacro: ( '<1s> is referenced.<n>Browse references?' expandMacrosWith: variableName );
				errorBlock:
						[ self openBrowserOn: ( RBBrowserEnvironment new instVarRefsTo: variableName in: class realClass ) ]
			].
	^ ( RBCondition definesInstanceVariable: variableName asString in: class ) & references not
]

{ #category : #transforming }
RBRemoveInstanceVariableRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
RBRemoveInstanceVariableRefactoring >> transform [
	self basicTransform
]
