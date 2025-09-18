Class {
	#name : #GtPharoSuiteOverviewElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtWithPharoSuiteViewModel',
	#classTraits : 'TGtWithPharoSuiteViewModel classTrait',
	#instVars : [
		'content',
		'fromStream'
	],
	#category : #'GToolkit-Pharo-TestSuite-UI-! Views'
}

{ #category : #initialization }
GtPharoSuiteOverviewElement >> initialize [
	super initialize.
	
	self
		vFitContent;
		hExact: 250;
		padding: (BlInsets all: 10);
		background: self theme default contentBackground.

	content := GtPharoSuiteOverviewContentElement new.
	self addChild: (fromStream := BrFromStream new
		hMatchParent;
		vFitContent;
		stencil: content;
		dataBinder: [ :anElement :aSnapshot | aSnapshot ifError: [ :anError |
				suiteViewModel executionError: anError.
				content updateErrorElement.
			Smalltalk logStdOutDuring: [ :logger |
				logger
					nextPutAll: '*** EXCEPTION ***'; cr;
					nextPutAll: anError printString; cr;
					nextPutAll: (String
						streamContents: [ :stream | anError signalerContext errorReportOn: stream ]); cr ] ] ])
]

{ #category : #'api - suite view model' }
GtPharoSuiteOverviewElement >> onSuiteViewModelChanged [
	"Is sent when a new suiteViewModel is assigned to the receiver.
	Note: #onSuiteViewModelChanged is sent before #subscribeToSuiteViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSuiteViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	content suiteViewModel: suiteViewModel.
	fromStream stream: suiteViewModel allSuiteCases sink: content asyncSink
]
