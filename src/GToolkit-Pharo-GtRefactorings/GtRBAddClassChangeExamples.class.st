Class {
	#name : #GtRBAddClassChangeExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #examples }
GtRBAddClassChangeExamples >> slots [
	<gtExample>
	| change |
	change := GtRBAddClassChange new
			definitionString: 'A123 << #B321 slots: {#foo => ObservableSlot . #bar => ToManyRelationSlot inverse: #first inClass: #OrderedCollection. #baz }';
			fillOutDefinition;
			yourself.
	self assert: change changeClassName equals: #B321.
	self assert: change superclassName equals: #A123.
	self assert: change instanceVariableNames asArray equals: #(foo bar baz).
	^ change
]

{ #category : #examples }
GtRBAddClassChangeExamples >> verifyChanges [
	<gtExample>
	(Object withAllSubclasses reject: #isClassSide)
		doWithIndex: [ :cls :index | 
			| change definition |
			index > 30000
				ifTrue: [  "If running in a large image, just check a subset"^ self ].
			definition := cls definitionString.
			change := GtRBAddClassChange new
					definitionString: definition;
					fillOutDefinition;
					yourself.
			self assert: change changeClassName equals: cls name.
			self
				assert: change superclassName
				equals: (cls superclass ifNotNil: [ :c | c name ]).
			self
				assert: change classVariableNames asSortedCollection
				equals: (cls classVariables collect: #key) asSortedCollection.
			self
				assert: change instanceVariableNames asArray
				equals: (cls localSlots collect: #name).
			self assert: change category equals: cls category.
			self assert: change package equals: cls package.
			self
				assert: change sharedPoolNames asSortedCollection
				equals: cls sharedPoolNames asSortedCollection.
			self
				assert: (change packageTagName
						ifNil: [ self
								forPharo12AndNewer: [ cls packageTag isRoot ]
								forPharo11: [ cls tags isEmpty ] ]
						ifNotNil: [ :t | (cls isTaggedWith: t) or: [ change packageName = t ] ]) ]
]
