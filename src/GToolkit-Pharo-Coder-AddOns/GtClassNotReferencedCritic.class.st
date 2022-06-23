Class {
	#name : #GtClassNotReferencedCritic,
	#superclass : #GtClassCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #testing }
GtClassNotReferencedCritic class >> isDefault [
	^ false
]

{ #category : #testing }
GtClassNotReferencedCritic >> classesToIgnore [
	^ #(BaselineOf SharedPool TestCase)
]

{ #category : #accessing }
GtClassNotReferencedCritic >> description [
	^ 'Class is not referenced and has no subclasses. If the class isn''t referenced using reflection (e.g., allSubclasses) then it can be removed.'
]

{ #category : #testing }
GtClassNotReferencedCritic >> matches: aBehavior from: aCriticRunner [
	| methodBlock |
	(aBehavior isInstanceSide
		and: [ aBehavior subclasses isEmpty
				and: [ (GtPharoCompletionStrategy globalVariableReferencesTo: aBehavior binding)
						isEmpty ] ]) ifFalse: [ ^ false ].
	aBehavior
		withAllSuperclassesDo: [ :each | (self classesToIgnore includes: each name) ifTrue: [ ^ false ] ].
	methodBlock := [ :each | 
		each
			pragmasDo: [ :pragma | (self pragmasToIgnore includes: pragma selector) ifTrue: [ ^ false ] ] ].
	aBehavior methodsDo: methodBlock.
	aBehavior class methodsDo: methodBlock.
	^ true
]

{ #category : #accessing }
GtClassNotReferencedCritic >> name [
	^ 'Class not referenced'
]

{ #category : #testing }
GtClassNotReferencedCritic >> pragmasToIgnore [
	^ #(gtExample example)
]
