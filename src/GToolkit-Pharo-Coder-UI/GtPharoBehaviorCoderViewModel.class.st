Class {
	#name : #GtPharoBehaviorCoderViewModel,
	#superclass : #GtSingleCoderViewModel,
	#instVars : [
		'definitionCoderUIModel',
		'currentAddOns'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #'api - coder model' }
GtPharoBehaviorCoderViewModel >> behavior [
	^ self coderModel behavior
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> computeAddOns [
	<return: #TAsyncPromise>

	^ [ self syncComputeAddOnsFor: coderModel ] asAsyncFuture
		await: (self class addOnsExecutionConfiguration)
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> definitionCoderUIModel [
	^ definitionCoderUIModel ifNil: [ self coder definitionCoder asCoderViewModel ]
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> elementClass [
	^ GtPharoBehaviorCoderElement
]

{ #category : #initialization }
GtPharoBehaviorCoderViewModel >> initialize [
	super initialize.
	
	extraAddOns := GtCoderAddOns new.
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> mainActions [ 
	^ currentAddOns ifNil: [ #() ] ifNotNil: [ 
		currentAddOns mainActions ]
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> onAddOnsChanged: theAddOns [
	"Is sent when new add-ons are computed"

	currentAddOns := theAddOns.
	self announce: (GtPharoBehaviorCoderViewModelAddonsChangedAnnouncement new
		pharoBehaviorCoderViewModel: self) 
]

{ #category : #'api - coder model' }
GtPharoBehaviorCoderViewModel >> onCoderModelChanged [
	super onCoderModelChanged.
	
	addOnPromise := nil.
	self ensureAddOns.
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> previews [ 
	^ currentAddOns ifNil: [ #() ] ifNotNil: [ 
		currentAddOns previews ]
]

{ #category : #'api - coder model' }
GtPharoBehaviorCoderViewModel >> protocols [
	^ self coderModel behavior protocols
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> syncComputeAddOnsFor: aCoderModel [
	| newAddOns pragmas |

	pragmas := aCoderModel
		pragmasNamed: GtCoderModel astExtensionsPragma
		inHierarchy: aCoderModel class.
	newAddOns := aCoderModel newAddOns.
	
	"extra addons"
	newAddOns addAddOns: aCoderModel addOns.
	"aCoderModel initializeShortcuts: newAddOns."
	aCoderModel initializeAddOns: newAddOns viewModel: self.
	
	pragmas reverseDo: [ :eachPragma |
		[ aCoderModel
				perform: eachPragma methodSelector
				withEnoughArguments: { newAddOns . self } ]
		on: Error
		do: [ :anError |
			"emit as a beacon signal"
			anError emit.
				
			NonInteractiveTranscript stderr
				nextPut: $[;
				print: eachPragma method printString;
				nextPut: $];
				space;
				print: anError;
				cr ] ].

	"view model add-ons override coder model add-ons"
	newAddOns addAddOns: extraAddOns.
	newAddOns markAsUpdated.
	^ newAddOns
]
