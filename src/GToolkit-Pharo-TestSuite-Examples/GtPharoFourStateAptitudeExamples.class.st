Class {
	#name : #GtPharoFourStateAptitudeExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #testing }
GtPharoFourStateAptitudeExamples class >> isAbstract [
	^ self name = #GtPharoFourStateAptitudeExamples
]

{ #category : #'examples - aptitude' }
GtPharoFourStateAptitudeExamples >> aptitudeClass [

	^ GtPharoFourStateAptitude
]

{ #category : #accessing }
GtPharoFourStateAptitudeExamples >> aptituteWithMethodCoders [

	<gtExample>
	| anAptitude |
	anAptitude := self basicAptitude coder: self methodsCoders.

	self
		assert: anAptitude updater isUpdateRequested
		description: [ 'Element update must be requested' ].

	^ anAptitude
]

{ #category : #'examples - aptitude' }
GtPharoFourStateAptitudeExamples >> basicAptitude [

	<gtExample>
	| anAptitude |
	anAptitude := self aptitudeClass new.

	self
		assert: anAptitude updater isUpdateRequested not
		description: [ 'Element update must not be requested' ].

	^ anAptitude
]

{ #category : #accessing }
GtPharoFourStateAptitudeExamples >> buttonWithAptitudeAndMethodCoders [

	<gtExample>
	| anAptitude anElement |
	anElement := BrButton new.
	anAptitude := self aptituteWithMethodCoders.
	anElement
		addAptitude: anAptitude;
		addAptitude: BrGlamorousButtonWithIconAptitude
			- BrGlamorousButtonWithLabelTooltipAptitude;
		icon: BrGlamorousVectorIcons play;
		label: 'Run All Examples'.

	self
		assert: anAptitude updater isUpdateRequested
		description: [ 'Element update must be requested' ].

	^ anElement
]

{ #category : #'examples - element' }
GtPharoFourStateAptitudeExamples >> elementWithAptitude [
	<gtExample>
	| anAptitude anElement |
	anElement := BlElement new.
	anAptitude := self basicAptitude.
	anElement aptitude: anAptitude.

	self
		assert: anAptitude updater isUpdateRequested not
		description: [ 'Element update must NOT be requested' ].

	^ anElement
]

{ #category : #'examples - element' }
GtPharoFourStateAptitudeExamples >> elementWithAptitudeAndMethodCoders [
	<gtExample>
	| anAptitude anElement |
	anElement := BlElement new.
	anAptitude := self aptituteWithMethodCoders.
	anElement aptitude: anAptitude.

	self
		assert: anAptitude updater isUpdateRequested
		description: [ 'Element update must be requested' ].

	^ anElement
]

{ #category : #'examples - coder' }
GtPharoFourStateAptitudeExamples >> methodsCoders [

	^ self subclassResponsibility
]
