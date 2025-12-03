Class {
	#name : #GtMoveMethodRefactoringController,
	#superclass : #GtExtractMethodToComponentController,
	#instVars : [
		'variableNode'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #private }
GtMoveMethodRefactoringController >> findExtractedSend [
	[ self sourceAst withAllNodesOfType: GtPharoMessageNode do: [ :each | ^ each ] ] on: SmaCCParserError do: [ :ex | ^ nil ].
	^ nil
]

{ #category : #accessing }
GtMoveMethodRefactoringController >> methodClass [
	^ sourceCoderViewModel behavior
]

{ #category : #accessing }
GtMoveMethodRefactoringController >> refactoring [
	| model refactoring |
	model := self createModel.
	refactoring := GtMoveMethodRefactoring
		model: model
		selector: variableNode topParent selector
		class: (model classFor: self methodClass)
		variable: variableNode variableName.
	refactoring
		setOption: #variableTypes toUse: [ :ref :types :selected | selected ];
		setOption: #selfArgumentName
			toUse:
				[ :ref | 
					| name |
					name := self methodClass name.
					(name first isVowel ifTrue: [ 'an' ] ifFalse: [ 'a' ]) , name ].
	^ refactoring
]

{ #category : #accessing }
GtMoveMethodRefactoringController >> refactoringName [
	^ 'Move method into variable ' , variableNode variableName
]

{ #category : #accessing }
GtMoveMethodRefactoringController >> variableNode: aNode [
	variableNode := aNode.
	receiver := aNode source.
	potentialReceivers := OrderedCollection with: receiver
]
