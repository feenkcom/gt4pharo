Class {
	#name : #GtRBNamespace,
	#superclass : #RBNamespace,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #accessing }
GtRBNamespace >> allImplementorsOfIncludingTraits: aSelector [
	| implementers |
	implementers := Set new.
	self newClasses
		do: [ :each | 
			each
				do: [ :cls | (cls directlyDefinesMethod: aSelector) ifTrue: [ implementers add: cls ] ] ].
	self changedClasses
		do: [ :each | 
			each
				do: [ :cls | (cls directlyDefinesMethod: aSelector) ifTrue: [ implementers add: cls ] ] ].
	(GtPharoIndex current implementersOf: aSelector)
		do: [ :each | 
			| cls |
			((environment includesMethod: each)
				and: [ each isFromTrait not
						and: [ (self hasRemoved: each methodClass instanceSide name) not ] ])
				ifTrue: [ each methodClass isTrait
						ifTrue: [ each methodClass users
								do: [ :user | (self classFor: user) ifNotNil: [ :c | implementers add: c ] ] ].
					cls := self classNamed: each methodClass name.
					(cls directlyDefinesMethod: aSelector) ifTrue: [ implementers add: cls ] ] ].
	^ implementers
]

{ #category : #accessing }
GtRBNamespace >> allMethodsWithPragma: aSymbol [
	| methods |
	methods := IdentitySet new.
	self allMethodsWithPragma: aSymbol do: [ :each | methods add: each ].
	^ methods
]

{ #category : #accessing }
GtRBNamespace >> allMethodsWithPragma: aSymbol do: aBlock [
	self
		allReferencesTo: aSymbol
		do: [ :each | each ast pragmaNamed: aSymbol ifPresent: [ :pragma | aBlock value: each ] ]
]

{ #category : #accessing }
GtRBNamespace >> allReferencesToClass: aRBClass do: aBlock [
	| refs |
	refs := OrderedCollection new.
	self newClasses
		do: [ :each | each do: [ :cls | (cls whichSelectorsReferToClass: aRBClass) 
			do: [ :aSelector | 
				refs add: (cls methodFor: aSelector)] ] ].
				
	self changedClasses
		do: [ :each | 
			each
				do: [ :cls | 
					cls newMethods
						do: [ :method | (method refersToClassNamed: aRBClass name) ifTrue: [ refs add: method ] ] ] ].
						
	(GtPharoIndex current globalVariableReferencesTo: aRBClass)
		do: [ :each | 
			| name cls |
			name := each methodClass instanceSide name.
			((self newClasses includesKey: name)
				or: [ (environment includesMethod: each) not
						or: [ cls := self classNamed: each methodClass name.
							(cls hasRemoved: each selector)
								or: [ cls newMethods includesKey: each selector ] ] ])
				ifFalse: [ refs add: (cls methodFor: each selector) ] ].
	refs do: aBlock
]

{ #category : #accessing }
GtRBNamespace >> createNewClassFor: aBehavior [
	^ self 
		forPharo12: [ super createNewClassFor: aBehavior] 
		forPharo11AndPharo10: [
			| nonMeta meta className rbType rbMetaType category behaviorName |
			className := aBehavior instanceSide name.
			aBehavior isTrait
				ifTrue: [ rbType := modelFactory rbTrait.
					rbMetaType := modelFactory rbTraitMetaclass ]
				ifFalse: [ rbType := modelFactory rbClass.
					rbMetaType := modelFactory rbMetaclass ].
			nonMeta := rbType existingNamed: className model: self.
			meta := rbMetaType existingNamed: className model: self.	"category := aBehavior category."
			category := aBehavior package name.
			behaviorName := aBehavior name.
			aBehavior package classTags
				detect: [ :each | each classNames includes: behaviorName ]
				ifFound: [ :tag | tag isRoot ifFalse: [ category := category , '-' , tag name ] ]
				ifNone: [  ].
			nonMeta category: category.
			changedClasses at: className put: (Array with: nonMeta with: meta) ]
]

{ #category : #accessing }
GtRBNamespace >> defineClass: aString withComment: aCommentString [
	| change newClass |
	change := self defineClass: aString.
	newClass := self classNamed: change changeClassName.
	aCommentString ifNotNil: [ newClass comment: aCommentString ].
	^ change
]

{ #category : #accessing }
GtRBNamespace >> privateImplementorsOf: aSelector [
	| implementers |
	implementers := Set new.
	self newClasses
		do: [ :each | 
			each
				do: [ :cls | (cls gtDirectlyDefinesMethod: aSelector) ifTrue: [ implementers add: cls ] ] ].
	self changedClasses
		do: [ :each | 
			each
				do: [ :cls | (cls gtDirectlyDefinesMethod: aSelector) ifTrue: [ implementers add: cls ] ] ].
	(GtPharoIndex current implementersOf: aSelector)
		do: [ :each | 
			((environment includesMethod: each)
				and: [ each isFromTrait not
						and: [ (self hasRemoved: each methodClass instanceSide name) not ] ])
				ifTrue: [ (self classNamed: each methodClass name)
						ifNotNil: [ :cls | (cls directlyDefinesMethod: aSelector) ifTrue: [ implementers add: cls ] ] ] ].
	^ implementers
]

{ #category : #accessing }
GtRBNamespace >> privateReferencesTo: aSelector [
	| refs |
	aSelector isSymbol ifFalse: [ ^ super privateReferencesTo: aSelector ].
	refs := OrderedCollection new.
	self newClasses
		do: [ :each | 
			each
				do: [ :cls | 
					(cls whichSelectorsReferToSymbol: aSelector)
						do: [ :sel | refs add: (cls methodFor: sel) ] ] ].
	self changedClasses
		do: [ :each | 
			each
				do: [ :cls | 
					cls newMethods
						do: [ :method | (method refersToSymbol: aSelector) ifTrue: [ refs add: method ] ] ] ].
	(GtPharoIndex current sendersOf: aSelector)
		do: [ :each | 
			| name cls |
			name := each methodClass instanceSide name.
			((self newClasses includesKey: name)
				or: [ (environment includesMethod: each) not
						or: [ cls := self classNamed: each methodClass name.
							cls isNil
								or: [ (cls hasRemoved: each selector)
										or: [ cls newMethods includesKey: each selector ] ] ] ])
				ifFalse: [ refs add: (cls methodFor: each selector) ] ].
	^ refs
]

{ #category : #accessing }
GtRBNamespace >> selectorsWithKeyword: aString [
	| selectors |
	selectors := Set
			withAll: ((GtPharoIndex current asyncSelectorsForWord: aString)
					select: [ :each | each keywords includes: aString ]) toArray wait.
	changedClasses
		do: [ :each | 
			each
				do: [ :cls | 
					cls newMethods
						do: [ :method | 
							(method selector keywords includes: aString)
								ifTrue: [ selectors add: method selector ] ] ] ].
	^ selectors
]
