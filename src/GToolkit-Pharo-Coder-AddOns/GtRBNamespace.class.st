Class {
	#name : #GtRBNamespace,
	#superclass : #RBNamespace,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #accessing }
GtRBNamespace >> allImplementorsOf: aSelector [ 
	^ (GtPharoIndex current implementersOf: aSelector) collect: [:each | self classNamed: each methodClass name ]
]

{ #category : #accessing }
GtRBNamespace >> allReferencesTo: aSelector [ 
	^ (GtPharoIndex current sendersOf: aSelector) collect: [:each | (self classNamed: each methodClass name) methodFor: each selector ]
]

{ #category : #accessing }
GtRBNamespace >> allReferencesToClass: aRBClass do: aBlock [ 
	| rbMethod |
	(GtPharoIndex current globalVariableReferencesTo: aRBClass) do: [ :method | 
		rbMethod := (self classNamed: method methodClass name) methodFor: method selector.
		aBlock value: rbMethod ].
	
	"self allClassesDo: 
			[:each |
			(each whichSelectorsReferToClass: aRBClass) 
				do: [:sel | aBlock value: (each methodFor: sel)].
			(each classSide whichSelectorsReferToClass: aRBClass) 
				do: [:sel | aBlock value: (each classSide methodFor: sel)]]"
]

{ #category : #accessing }
GtRBNamespace >> createNewClassFor: aBehavior [
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
	^ changedClasses at: className put: (Array with: nonMeta with: meta)
]
