"
I exemplify {{gtClass:GtPharoWhenSendToExpanderStyler}}. 
"
Class {
	#name : #GtPharoWhenSendToExpanderStylerExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #'examples - source code' }
GtPharoWhenSendToExpanderStylerExamples >> onAnnouncement: anAnnouncement [

	NonInteractiveTranscript stdout show: anAnnouncement
]

{ #category : #'examples - styling' }
GtPharoWhenSendToExpanderStylerExamples >> styleCascadeWhenSendTo [

	<gtExample>
	| aCoder anAst aSourceText allRedIntervals aCoderViewModel |
	aCoder := GtPharoSnippetCoder forSource: (Announcer name
		           ,
		           ' new when: Announcement send: #onAnnouncement: to: self; yourself')
			          asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.
	aCoderViewModel := aCoder asCoderViewModel.
	aCoderViewModel selfObject: self.

	GtPharoWhenSendToExpanderStyler new
		coderViewModel: aCoderViewModel;
		style: aSourceText ast: anAst.

	allRedIntervals := OrderedCollection new.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | 
			eachAttribute isKindOf: GtPharoMethodExpanderAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			allRedIntervals add: (aStartPosition to: anEndPosition) ].

	self assert: allRedIntervals size equals: 1.
	self assert: allRedIntervals asArray equals: { (55 to: 55) }.

	^ aSourceText
]

{ #category : #'examples - styling' }
GtPharoWhenSendToExpanderStylerExamples >> styleWhenSendTo [

	<gtExample>
	| aCoder anAst aSourceText allRedIntervals aCoderViewModel |
	aCoder := GtPharoSnippetCoder forSource: (Announcer name
		           ,
		           ' new when: Announcement send: #onAnnouncement: to: self')
			          asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.
	aCoderViewModel := aCoder asCoderViewModel.
	aCoderViewModel selfObject: self.

	GtPharoWhenSendToExpanderStyler new
		coderViewModel: aCoderViewModel;
		style: aSourceText ast: anAst.

	allRedIntervals := OrderedCollection new.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | 
			eachAttribute isKindOf: GtPharoMethodExpanderAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			allRedIntervals add: (aStartPosition to: anEndPosition) ].

	self assert: allRedIntervals size equals: 1.
	self assert: allRedIntervals asArray equals: { (55 to: 55) }.

	^ aSourceText
]

{ #category : #'examples - source code' }
GtPharoWhenSendToExpanderStylerExamples >> whenSendToSubscription [

	<gtExample>
	| anAnnouncer |
	anAnnouncer := Announcer new.

	anAnnouncer weak when: Announcement send: #onAnnouncement: to: self.

	^ anAnnouncer
]
