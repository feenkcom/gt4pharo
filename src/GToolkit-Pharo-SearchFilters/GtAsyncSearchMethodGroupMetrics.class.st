Class {
	#name : #GtAsyncSearchMethodGroupMetrics,
	#superclass : #Object,
	#traits : 'TGtWithAnnouncer',
	#classTraits : 'TGtWithAnnouncer classTrait',
	#instVars : [
		'amountOfMethods',
		'linesOfCode'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Streams'
}

{ #category : #initialization }
GtAsyncSearchMethodGroupMetrics >> accumulateMethod: aCompiledMethod [
	amountOfMethods := amountOfMethods + 1.
	linesOfCode := linesOfCode + aCompiledMethod linesOfCode.
	self announce: GtAsyncSearchMethodMetricsUpdate new
]

{ #category : #accessing }
GtAsyncSearchMethodGroupMetrics >> amountOfMethods [

	^ amountOfMethods
]

{ #category : #'gt - extensions' }
GtAsyncSearchMethodGroupMetrics >> gtMetricsFor: aView [

	<gtView>
	^ aView columnedList
		  title: 'Metrics';
		  items: [ 
			  { 
				  ('Number of methods' -> self amountOfMethods).
				  ('Lines of code' -> self linesOfCode).
				  ('Lines per method' -> (self amountOfMethods isZero
						    ifFalse: [ 
							    (self linesOfCode / self amountOfMethods) asFloat ]
						    ifTrue: [ '0' ])) } ];
		  column: 'Metric' text: #key;
		  column: 'Value' text: [ :assoc | assoc value asString ];
		  updateWhen: GtAsyncSearchMethodMetricsUpdate in: [ self announcer ];
		  actionUpdateButton
]

{ #category : #initialization }
GtAsyncSearchMethodGroupMetrics >> initialize [
	super initialize.
	
	amountOfMethods := 0.
	linesOfCode := 0
]

{ #category : #accessing }
GtAsyncSearchMethodGroupMetrics >> linesOfCode [

	^ linesOfCode
]
