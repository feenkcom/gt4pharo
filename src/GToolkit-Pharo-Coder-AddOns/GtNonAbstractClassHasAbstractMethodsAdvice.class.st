Class {
	#name : #GtNonAbstractClassHasAbstractMethodsAdvice,
	#superclass : #GtAdvice,
	#instVars : [
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Advice'
}

{ #category : #accessing }
GtNonAbstractClassHasAbstractMethodsAdvice >> behavior [
	^ behavior
]

{ #category : #accessing }
GtNonAbstractClassHasAbstractMethodsAdvice >> behavior: aBehavior [
	behavior := aBehavior
]

{ #category : #accessing }
GtNonAbstractClassHasAbstractMethodsAdvice >> buildActionsIn: anElement for: aButton [
	anElement
		addChild: (BrButton new
				margin: (BlInsets left: 20);
				aptitude: BrGlamorousButtonWithLabelAptitude;
				label: 'Browse methods';
				action: [ :button | 
					aButton phlow
						spawnObject: #subclassResponsibility gtReferences & behavior gtMethodsInClass ])
]

{ #category : #accessing }
GtNonAbstractClassHasAbstractMethodsAdvice >> description [
	^ (behavior name asString
		, ' has no subclasses, but has methods marked with subclassResponsibility.')
		asRopedText
]

{ #category : #accessing }
GtNonAbstractClassHasAbstractMethodsAdvice >> name [
	^ 'Abstract methods in non abstract class'
]
