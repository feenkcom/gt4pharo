Class {
	#name : #GtDefinesEqualButNotHashCritic,
	#superclass : #GtClassCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtDefinesEqualButNotHashCritic >> description [
	^ 'Class defines #=, but not a corresponding #hash method. This may cause problems when using hashed collections.'
]

{ #category : #testing }
GtDefinesEqualButNotHashCritic >> matches: aBehavior from: aCriticRunner [
	^ (aBehavior includesSelector: #=)
		and: [ (aBehavior includesSelector: #hash) not ]
]

{ #category : #accessing }
GtDefinesEqualButNotHashCritic >> name [
	^ 'Defines #= but not #hash'
]
