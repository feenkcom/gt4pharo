Class {
	#name : #GtCompilationNotificationSummary,
	#superclass : #GtNotificationSummary,
	#instVars : [
		'executedLabel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtCompilationNotificationSummary >> initialize [
	super initialize.
	self
		constraintsDo: [ :c | 
			c vertical exact: 21.
			c horizontal fitContent ].
	self layout: BlLinearLayout horizontal.
	self border: (BlBorder paint: Color orange width: 2).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self padding: (BlInsets left: 5 right: 5).
	self background: Color white.

	self
		addChild: (executedLabel := BrLabel new
					aptitude: BrGlamorousLabelAptitude;
					beSmallSize;
					hFitContent;
					vExact: 15;
					margin: (BlInsets all: 3);
					layout: BlLinearLayout horizontal alignCenter;
					geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
					text: 'Compiling 0%')
]

{ #category : #accessing }
GtCompilationNotificationSummary >> subscribeToNotifications [
	notifications
		do: [ :each | 
			each job announcer
				when: JobChange
				send: #requestUpdate
				to: self ]
]

{ #category : #accessing }
GtCompilationNotificationSummary >> unsubscribeFromNotifications [
	notifications do: [ :each | each job announcer unsubscribe: self ]
]

{ #category : #accessing }
GtCompilationNotificationSummary >> updateSummaryContent [
	| compiled total |
	compiled := total := 0.
	self notifications
		do: [ :each | 
			compiled := compiled + each job currentValue.
			total := total + each job max ].
	executedLabel
		text: 'Compiling ' , (compiled * 100 / total printShowingDecimalPlaces: 0) , '%'
]
