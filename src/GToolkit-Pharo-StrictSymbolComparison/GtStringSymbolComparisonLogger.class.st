Class {
	#name : #GtStringSymbolComparisonLogger,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#instVars : [
		'logger'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Logging'
}

{ #category : #'private - hooks' }
GtStringSymbolComparisonLogger class >> onRemoveUniqueInstance: anInstance [
	"Classes may perform some activities on a singleton that is about to be released"
	
	anInstance stop
]

{ #category : #'start - stop' }
GtStringSymbolComparisonLogger class >> start [

	self uniqueInstance start.
	^ self uniqueInstance
]

{ #category : #'start-stop' }
GtStringSymbolComparisonLogger >> start [

	self subclassResponsibility
]

{ #category : #'start-stop' }
GtStringSymbolComparisonLogger >> stop [

	logger ifNotNil:
		[ logger stop ].
]
