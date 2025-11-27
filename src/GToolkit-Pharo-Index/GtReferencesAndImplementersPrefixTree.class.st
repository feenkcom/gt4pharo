Class {
	#name : #GtReferencesAndImplementersPrefixTree,
	#superclass : #GtReferencesPrefixTree,
	#instVars : [
		'implementers'
	],
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #adding }
GtReferencesAndImplementersPrefixTree >> addImplementer: aMethod [
	implementers
		ifNil: [ implementers := aMethod ]
		ifNotNil: [ implementers class == OrderedCollection
				ifFalse: [ implementers := implementers isArray
							ifTrue: [ implementers := implementers asOrderedCollection ]
							ifFalse: [ OrderedCollection with: implementers ] ].
			implementers add: aMethod ].
	
	self checkForNotInstalledImplementers.
]

{ #category : #debugging }
GtReferencesAndImplementersPrefixTree >> checkForNotInstalledImplementers [
	self class isDebuggingEnabled ifFalse: [ ^ self ].
	
	self hasNotInstalledImplementers ifTrue: [
		self notifyNotInstalledImplementers ]
]

{ #category : #private }
GtReferencesAndImplementersPrefixTree >> compressData [
	super compressData.
	implementers isCollection ifTrue: [ implementers := implementers asArray ]
]

{ #category : #'gt - extensions' }
GtReferencesAndImplementersPrefixTree >> gtImplementersAreInstalled: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice asyncStream
		priority: 10;
		description: [ :each | (each , ' has an implementer that is not installed') asRopedText ];
		compute: [ (self asyncStreamStartingWith: '')
				select: [ :each | 
					(self nodeFor: each) implementersCollection
						anySatisfy: [ :method | method gtIsActive not ] ] ];
		action: [ :each | self gtPhlowInspectNodeAction: each ]
]

{ #category : #'gt - extensions' }
GtReferencesAndImplementersPrefixTree >> gtImplementersFor: aView [
	<gtView>
	^ aView list
		title: 'Implementers';
		items: [ implementers
				ifNil: [ #() ]
				ifNotNil: [ implementers isCollection
						ifTrue: [ implementers ]
						ifFalse: [ Array with: implementers ] ] ]
]

{ #category : #accessing }
GtReferencesAndImplementersPrefixTree >> gtLocalSizeInMemory [
	^ super gtLocalSizeInMemory
		+ ((implementers isArray or: [ implementers class == OrderedCollection ])
				ifTrue: [ implementers gtSpecificSizeInMemory ]
				ifFalse: [ 0 ])
]

{ #category : #'gt - extensions' }
GtReferencesAndImplementersPrefixTree >> gtMethodNotInCache: aGtAdvice [
	<gtAdvice>
	prefix = '' ifFalse: [ ^ aGtAdvice none ].
	^ aGtAdvice asyncStream
		priority: 100;
		description: [ :each | (each selector asString , ' is not in the implementers cache') asRopedText ];
		compute: [ AsyncImageMethodsStream new
				select: [ :each | 
					each isFromTrait not
						and: [ (self nodeFor: each selector)
								ifNil: [ true ]
								ifNotNil: [ :node | (node implementersCollection includes: each gtIndexMethod) not ] ] ] ];
		action: [ :each | 
			(GtPhlowObjectAdviceAction object: each)
				title: each printString asRopedText;
				yourself ]
]

{ #category : #'gt - extensions' }
GtReferencesAndImplementersPrefixTree >> gtNoDuplicateImplementers: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice asyncStream
		priority: 20;
		description: [ :each | (each , ' has duplicate implementer methods') asRopedText ];
		compute: [ (self asyncStreamStartingWith: '')
				select: [ :each | 
					(self nodeFor: each) implementersCollection
						ifEmpty: [ false ]
						ifNotEmpty: [ :col | col size ~= col asIdentitySet size ] ] ];
		action: [ :each | self gtPhlowInspectNodeAction: each ]
]

{ #category : #'gt - extensions' }
GtReferencesAndImplementersPrefixTree >> gtNotInstalledImplementersBySelector [ 
	| notInstalledMethodsBySelector |
	notInstalledMethodsBySelector 	:= OrderedDictionary new.
	((self asyncStreamStartingWith: '')	do: [ :each | 
		| notInstalledReferences |
		notInstalledReferences := ((self nodeFor: each) implementersCollection
				select: [ :method | method gtIsActive not ]).
		notInstalledReferences ifNotEmpty: [
			notInstalledMethodsBySelector 
				at: each 
				put: notInstalledReferences] ]) wait.
	^ notInstalledMethodsBySelector
]

{ #category : #'debugging - testing' }
GtReferencesAndImplementersPrefixTree >> hasNotInstalledImplementers [
	implementers ifNil: [ ^ false ].
	implementers gtIsIndexMethod ifTrue: [ 
		^ implementers gtIsActive not ].
	((implementers isArray) or: [implementers class == OrderedCollection])
		ifTrue: [ 
			^ implementers anySatisfy: [ :each | each gtIsActive not ] ].
	^ false
]

{ #category : #private }
GtReferencesAndImplementersPrefixTree >> implementers [
	^ implementers
]

{ #category : #private }
GtReferencesAndImplementersPrefixTree >> implementers: aCollection [
	implementers := aCollection
]

{ #category : #accessing }
GtReferencesAndImplementersPrefixTree >> implementersCollection [
	^ implementers ifNil: [ #() ] ifNotNil: [ implementers asOrderedCollection ]
]

{ #category : #accessing }
GtReferencesAndImplementersPrefixTree >> implementersOf: aString [
	^ ((self nodeFor: aString) ifNotNil: [ :node | node implementers ])
		ifNil: [ #() ]
		ifNotNil: [ :impls | impls asOrderedCollection ]
]

{ #category : #private }
GtReferencesAndImplementersPrefixTree >> moveDataTo: newChild [
	super moveDataTo: newChild.
	newChild implementers: implementers.
	implementers := nil
]

{ #category : #accessing }
GtReferencesAndImplementersPrefixTree >> notInstalledMethods [
	^ super notInstalledMethods, ((self gtImplementersAreInstalled: GtNoAdvice new) result toArray wait)
]

{ #category : #debugging }
GtReferencesAndImplementersPrefixTree >> notifyNotInstalledImplementers [
	| notInstalledImplementors message |
	notInstalledImplementors := self implementersCollection 
		reject: [ :each | each gtIsActive ].
	message:= ('Found {1} implementors not installed in the image: {2}'
		format: {
			notInstalledImplementors size.
			(notInstalledImplementors asArray collect: [:each |
				each printString ]) asCommaString
		}).
	GtWorld showNotification: (GtNotificationMessage message: message)
		showNotifications
]

{ #category : #removing }
GtReferencesAndImplementersPrefixTree >> removeImplementer: aMethod [
	| index |
	implementers ifNil: [ ^ self ].
	implementers == aMethod ifTrue: [ ^ implementers := nil ].
	implementers isArray
		ifTrue: [ implementers := implementers asOrderedCollection ].
	implementers class == OrderedCollection ifFalse: [ ^ self ].
	index := implementers identityIndexOf: aMethod.
	index > 0 ifTrue: [ implementers removeAt: index ].
]

{ #category : #accessing }
GtReferencesAndImplementersPrefixTree >> updateImplementer: aMethod [
	implementers ifNil: [ ^ self addImplementer: aMethod ].
	implementers gtIsIndexMethod
		ifTrue: [ ^ implementers methodClass = aMethod methodClass
				ifTrue: [ implementers := aMethod ]
				ifFalse: [ self addImplementer: aMethod ] ].
	1
		to: implementers size
		do: [ :i | 
			| each |
			each := implementers at: i.
			each methodClass = aMethod methodClass
				ifTrue: [ ^ implementers at: i put: aMethod ] ].
	^ self addImplementer: aMethod
]
