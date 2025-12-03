"
I hide secret information written in a code, e.g., passwords and tokens.
#Examples
##Password
The following code includes a password that should be hidden by default: {{gtExample:GtPharoMethodPasswordStylerExamples >> #usernameAndPasswordSourceCode}}
##Bearer
The following code includes apassword that should be hidden by default: {{gtExample: GtPharoMethodPasswordStylerExamples >> #bearerSourceCode}}
#Extensions
Other projects may extend the list of possible selectors with passwords by defining methods similar to {{gtMethod:GtPharoMethodPasswordStyler >> #usernamePassword | expanded=true}}: 
"
Class {
	#name : #GtPharoMethodPasswordStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'collector',
		'definitions'
	],
	#classInstVars : [
		'pragmaCollector'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Zinc'
}

{ #category : #accessing }
GtPharoMethodPasswordStyler class >> cleanUp: aggressive [
	pragmaCollector := nil
]

{ #category : #'gt - extensions' }
GtPharoMethodPasswordStyler class >> gtSelectorsFor: aView [

	<gtView>
	<gtClassView>
	^ aView forward
		  title: 'Passwords';
		  tooltip: 'Message selectors with possible passwords';
		  priority: 30;
		  object: [ self new ];
		  view: #gtSelectorsFor:
]

{ #category : #accessing }
GtPharoMethodPasswordStyler class >> newPragmaCollector [
	| aCollector |
	aCollector := PragmaCollector
			selectors: #(#gtMethodPassword)
			filter: [ :aPragma | aPragma methodClass = self and: [ aPragma methodSelector numArgs = 0 ] ].
	aCollector reset.
	^ aCollector
]

{ #category : #accessing }
GtPharoMethodPasswordStyler class >> pragmaCollector [
	^ pragmaCollector ifNil: [ pragmaCollector := self newPragmaCollector ]
]

{ #category : #comparing }
GtPharoMethodPasswordStyler >> = anObject [
	^ self class = anObject class
]

{ #category : #accessing }
GtPharoMethodPasswordStyler >> definitions [

	^ definitions ifNil: [ 
		  definitions := collector collect: [ :eachPragma | 
			                 self perform: eachPragma methodSelector ] ]
]

{ #category : #'gt - extensions' }
GtPharoMethodPasswordStyler >> gtSelectorsFor: aView [

	<gtView>
	collector ifNil: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Passwords';
		  tooltip: 'Message selectors with possible passwords';
		  priority: 10;
		  updateWhen: PragmaCollectorReset , PragmaAnnouncement
		  	in: [ collector announcer ];
		  items: [ self definitions ];
		  column: 'Method Selector' text: #selector;
		  column: 'Password position' text: #position
]

{ #category : #comparing }
GtPharoMethodPasswordStyler >> hash [
	^ self class hash
]

{ #category : #initialization }
GtPharoMethodPasswordStyler >> initialize [
	super initialize.

	collector := self class pragmaCollector.
	collector announcer weak
		when: PragmaCollectorReset , PragmaAnnouncement
		send: #onPragmaCollectorChanged:
		to: self
]

{ #category : #'private - announcement handling' }
GtPharoMethodPasswordStyler >> onPragmaCollectorChanged: anAnnouncement [

	definitions := nil
]

{ #category : #selectors }
GtPharoMethodPasswordStyler >> password [

	<gtMethodPassword>
	^ self registerSelector: #password: position: 1
]

{ #category : #accessing }
GtPharoMethodPasswordStyler >> pragmaCollector [
	^ self class pragmaCollector
]

{ #category : #convenience }
GtPharoMethodPasswordStyler >> registerSelector: aSelector position: aPosition [

	"Register a method selector that may include a password as a string.
	aPosition indicates at what possition the password may appear."

	^ GtPharoMethodPasswordDefinition new
		  selector: aSelector;
		  position: aPosition
]

{ #category : #accessing }
GtPharoMethodPasswordStyler >> selectorsWithPasswordArguments [

	^ collector collected 
]

{ #category : #selectors }
GtPharoMethodPasswordStyler >> setBearerAuthentication [

	<gtMethodPassword>
	^ self registerSelector: #setBearerAuthentication: position: 1
]

{ #category : #selectors }
GtPharoMethodPasswordStyler >> usernamePassword [

	<gtMethodPassword>
	^ self registerSelector: #username:password: position: 2
]

{ #category : #selectors }
GtPharoMethodPasswordStyler >> usernameTokenUrl [

	<gtMethodPassword>
	^ self registerSelector: #username:token:url: position: 2
]

{ #category : #accessing }
GtPharoMethodPasswordStyler >> visitKeywordMessage: aMessage [

	| aMessageDefinition aStartPosition aStopPosition |
	super visitKeywordMessage: aMessage.

	aMessageDefinition := self definitions
		                      detect: [ :eachDef | 
		                     	eachDef isForMessage: aMessage ]
		                      ifFound: [ :theDefinition | theDefinition ]
		                      ifNone: [ ^ self ].

	aStartPosition := aMessageDefinition startPositionFor: aMessage.
	aStopPosition := aMessageDefinition stopPositionFor: aMessage.

	self
		attribute: (BrTextReplacingAttribute new withCharacter: $*)
		from: aStartPosition
		to: aStopPosition.
	(text from: aStartPosition to: aStopPosition)
		onCursorEnter: [ :aTextEditor :anEvent :aFromIndex :aToIndex | 
			(aTextEditor text from: aFromIndex to: aToIndex) 
				clearAttributesOfClass: BrTextReplacingAttribute ]
		leave: [ :aTextEditor :anEvent :aFromIndex :aToIndex | 
			(aTextEditor text from: aFromIndex to: aToIndex)
				clearAttributesOfClass: BrTextReplacingAttribute;
				attribute: (BrTextReplacingAttribute new withCharacter: $*) ]
]
