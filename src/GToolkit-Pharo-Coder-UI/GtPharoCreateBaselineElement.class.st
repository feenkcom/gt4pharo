Class {
	#name : #GtPharoCreateBaselineElement,
	#superclass : #GtPharoCreateBehaviorElement,
	#category : #'GToolkit-Pharo-Coder-UI-Behavior'
}

{ #category : #accessing }
GtPharoCreateBaselineElement >> compileBehavior [

	| change |
	change := definition createChange.
	GtPharoCodeModifier current performRefactoryChange: change.

	behaviorBlock ifNil: [ ^ self ].

	change changes
		detect: [ :each | each isKindOf: RBRefactoryDefinitionChange ]
		ifFound: [ :aChange | behaviorBlock cull: aChange definedClass ]
		ifNone: [ self error: 'It must not happen' ]
]

{ #category : #initialization }
GtPharoCreateBaselineElement >> forPackageReference: aPackage [

	definition forPackageReference: aPackage
]
