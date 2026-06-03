Class {
	#name : #GtMethodAdviceSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'advice',
		'styler'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices-Signals'
}

{ #category : #accessing }
GtMethodAdviceSignal >> advice [
	^ advice
]

{ #category : #accessing }
GtMethodAdviceSignal >> advice: anObject [
	advice := anObject
]

{ #category : #accessing }
GtMethodAdviceSignal >> styler [
	^ styler
]

{ #category : #accessing }
GtMethodAdviceSignal >> styler: anObject [
	styler := anObject
]
