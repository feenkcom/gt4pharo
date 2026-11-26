Class {
	#name : #GtBehaviorClassDefinitionExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #'examples - validation' }
GtBehaviorClassDefinitionExamples >> definitionWithEmptyNameIsInvalid [
	<gtExample>
	| definition |
	definition := self fromClass.
	definition name: ''.
	
	self assert: definition name equals: #''.
	self assert: definition isValidForCreation not.
]

{ #category : #'examples - validation' }
GtBehaviorClassDefinitionExamples >> definitionWithSameNameIsInvalid [
	<gtExample>
	| definition |
	definition := self fromClass.
	
	self assert: definition name equals: self targetClass name.
	self assert: definition isValidForCreation not.
]

{ #category : #'instance creation' }
GtBehaviorClassDefinitionExamples >> fromClass [
	<gtExample>
	| aDefinition |

	aDefinition := GtClassDefinition fromClass: self targetClass.

	self assert: aDefinition name equals: #GtBehaviorCoderDummyClass.
	self assert: aDefinition hasParent not.

	self assert: aDefinition traits parent == aDefinition.
	self assert: aDefinition traits size equals: 1.
	self assert: (aDefinition traits at: 1) name equals: #TGtBehaviorCoderDummyTrait.
	self assert: (aDefinition traits at: 1) parent == aDefinition.
	
	self assert: aDefinition slots parent == aDefinition.
	self assert: aDefinition slots size equals: 3.
	
	self assert: (aDefinition slots at: 1) name equals: #instVarA.
	self assert: (aDefinition slots at: 1) type equals: #InstanceVariableSlot.
	self assert: (aDefinition slots at: 1) parent == aDefinition.
	
	self assert: (aDefinition slots at: 2) name equals: #instVarB.
	self assert: (aDefinition slots at: 2) type equals: #InstanceVariableSlot.
	self assert: (aDefinition slots at: 2) parent == aDefinition.
	
	self assert: (aDefinition slots at: 3) name equals: #instVarC.
	self assert: (aDefinition slots at: 3) type equals: #InstanceVariableSlot.
	self assert: (aDefinition slots at: 3) parent == aDefinition.

	^ aDefinition
]

{ #category : #'examples - differences' }
GtBehaviorClassDefinitionExamples >> renameClassVariableWithStrings [
	"The editor passes the names as Strings"

	<gtExample>
	<return: #GtClassDefinition>
	| definition |
	definition := self fromClass.
	definition classVariables renameClassVariableNamed: 'ClassVarA' to: 'ClassVarX'.

	self assert: (definition classVariables hasDefinitionNamed: #ClassVarX).
	self assert: (definition classVariables hasDefinitionNamed: #ClassVarA) not.
	self assert: (definition classVariables classVariableNamed: #ClassVarX) name isSymbol.
	self
		assert: (definition differenceWith: (GtClassDefinition fromClass: self targetClass)) hasDifference.

	^ definition
]

{ #category : #'examples - differences' }
GtBehaviorClassDefinitionExamples >> renameSlotWithStrings [
	"The editor passes the names as Strings"

	<gtExample>
	<return: #GtClassDefinition>
	| definition |
	definition := self fromClass.
	definition slots renameSlotNamed: 'instVarA' to: 'instVarX'.

	self assert: (definition slots hasDefinitionNamed: #instVarX).
	self assert: (definition slots hasDefinitionNamed: #instVarA) not.
	self
		assert: (definition differenceWith: (GtClassDefinition fromClass: self targetClass)) hasDifference.

	^ definition
]

{ #category : #'examples - differences' }
GtBehaviorClassDefinitionExamples >> sameClassVariableIsNoDifference [
	"Setting a class variable name to the text it already has changes nothing"

	<gtExample>
	<return: #GtClassDefinition>
	| definition |
	definition := self fromClass.
	(definition classVariables classVariableNamed: #ClassVarA) name: 'ClassVarA'.

	self assert: (definition classVariables classVariableNamed: #ClassVarA) name isSymbol.
	self
		assert: (definition differenceWith: (GtClassDefinition fromClass: self targetClass)) hasDifference not.

	^ definition
]

{ #category : #'examples - differences' }
GtBehaviorClassDefinitionExamples >> sameTagIsNoDifference [
	"Setting the tag to the text it already has changes nothing"

	<gtExample>
	<return: #GtClassDefinition>
	| definition |
	definition := self fromClass.
	definition category tag name: 'Dummies'.

	self
		assert: (definition differenceWith: (GtClassDefinition fromClass: self targetClass)) hasDifference not.

	^ definition
]

{ #category : #'examples - differences' }
GtBehaviorClassDefinitionExamples >> tagFromClassIsSymbol [
	"The tag read from a class is a Symbol, as the tag the editor sets"

	<gtExample>
	<return: #GtClassDefinition>
	| definition |
	definition := self fromClass.

	self assert: definition category tag name equals: #Dummies.
	self assert: definition category tag name isSymbol.

	^ definition
]

{ #category : #access }
GtBehaviorClassDefinitionExamples >> targetClass [
	^ GtBehaviorCoderDummyClass
]
