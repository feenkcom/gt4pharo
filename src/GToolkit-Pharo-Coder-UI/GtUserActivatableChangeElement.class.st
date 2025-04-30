Class {
	#name : #GtUserActivatableChangeElement,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'activatableChange'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #'instance creation' }
GtUserActivatableChangeElement class >> fromActivatableChange: aGtUserActivatableChange [
	^ self new activatableChange: aGtUserActivatableChange
]

{ #category : #accessing }
GtUserActivatableChangeElement >> activatableChange [
	^ activatableChange
]

{ #category : #'instance creation' }
GtUserActivatableChangeElement >> activatableChange: aGtUserActivatableChange [
	self removeChildren.

	activatableChange := aGtUserActivatableChange.
	
	self addChild: ((aGtUserActivatableChange hasDiffChange)
		ifTrue: [ aGtUserActivatableChange change gtDiffChange asElement vFitContent beSmallSize ]
		ifFalse: [ BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				text: aGtUserActivatableChange change displayString ])
]

{ #category : #initialization }
GtUserActivatableChangeElement >> initialize [
	super initialize.
	
	self hMatchParent.
	self vFitContent.
	
	
]
