Class {
	#name : #GtPharoBehaviorDefinitionCoder,
	#superclass : #GtCoderModel,
	#traits : 'TGtCoderTrait',
	#classTraits : 'TGtCoderTrait classTrait',
	#instVars : [
		'behavior',
		'definition'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'instance creation' }
GtPharoBehaviorDefinitionCoder class >> forBehavior: aBehavior [
	^ self new forBehavior: aBehavior
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoder >> behavior [
	<return: #Behavior>

	^ behavior
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoder >> definition [
	^ definition ifNil: [ definition := self definitionFrom: self behavior ]
]

{ #category : #'api - initialization' }
GtPharoBehaviorDefinitionCoder >> definitionFrom: aBehavior [
	^ GtBehaviorDefinition fromBehavior: aBehavior
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoder >> difference [
	<return: #GtCodeDefinitionDifference>
	
	^ self definition differenceWith: (self definitionFrom: self behavior)
]

{ #category : #'api - initialization' }
GtPharoBehaviorDefinitionCoder >> forBehavior: aBehavior [
	behavior := aBehavior.
	definition := nil.
	self subscribeToSystem
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoder >> onClassChanged: anAnnouncement [
	anAnnouncement classAffected == behavior ifFalse: [^self].
	definition := nil.
	self announce: (GtCoderClassChanged new coder: self)
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoder >> refactorings [	
	^  self definition difference: self difference toRefactoringsOf: self behavior
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoder >> subscribeToSystem [

	SystemAnnouncer uniqueInstance weak
		when: ClassAnnouncement send: #onClassChanged: to: self
]
