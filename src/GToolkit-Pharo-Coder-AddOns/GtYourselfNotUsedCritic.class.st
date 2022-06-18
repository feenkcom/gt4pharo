Class {
	#name : #GtYourselfNotUsedCritic,
	#superclass : #GtSendNotUsedCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtYourselfNotUsedCritic >> description [
	^ '#yourself is a message that returns the receiver. If this message isn''t used, then it can be removed.'
]

{ #category : #accessing }
GtYourselfNotUsedCritic >> selectors [
	^ #(yourself)
]
