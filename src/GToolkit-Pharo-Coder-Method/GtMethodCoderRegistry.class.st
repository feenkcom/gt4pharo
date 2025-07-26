"
{{gtClass:GtMethodCoderRegistry}} tracks all of the coders that can be used in a {{gtClass:GtPharoStreamingMethodsCoder}}. Each class must provide a `priority` and an `isCoderValidFor:in:` method. This registry chooses a coder based on the first class in priority order for which the `isCoderValidFor:in:` method is true.
"
Class {
	#name : #GtMethodCoderRegistry,
	#superclass : #Object,
	#instVars : [
		'coderClasses'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #accessing }
GtMethodCoderRegistry class >> default [
	^UniqueInstance ifNil: [UniqueInstance := self new]
]

{ #category : #accessing }
GtMethodCoderRegistry class >> reset [
	UniqueInstance := nil
]

{ #category : #'as yet unclassified' }
GtMethodCoderRegistry >> addCoderClass: aClass [
	coderClasses add: aClass
]

{ #category : #initialization }
GtMethodCoderRegistry >> initialize [
	super initialize.
	coderClasses := SortedCollection sortBlock: [:a :b | a priority < b priority]
]

{ #category : #'private - instance creation' }
GtMethodCoderRegistry >> newCoderFor: aCompiledMethod in: behavior [
	| coderClass |
	coderClass := coderClasses
			detect: [ :each | each isCoderValidFor: aCompiledMethod ]
			ifNone: [ GtPharoMethodCoder ].
	^ coderClass forMethod: aCompiledMethod in: behavior
]
