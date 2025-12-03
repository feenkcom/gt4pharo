Class {
	#name : #GtYourselfNotUsedAdvice,
	#superclass : #GtSendNotUsedAdvice,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtYourselfNotUsedAdvice >> description [
	^ '#yourself is a message that returns the receiver. If this message isn''t used, then it can be removed.'
]

{ #category : #accessing }
GtYourselfNotUsedAdvice >> selectors [
	^ #(yourself)
]
