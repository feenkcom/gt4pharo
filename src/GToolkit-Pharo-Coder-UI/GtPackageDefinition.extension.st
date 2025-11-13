Extension { #name : #GtPackageDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPackageDefinition >> browseFrom: anEvent [
	| aRealPackage aCoderEvent aPackageCoder |

	aRealPackage := self packageOrganizer
		packageNamed: self name
		ifAbsent: [ ^ self ].

	aPackageCoder := GtPharoPackageCoder forPackage: aRealPackage.
	aCoderEvent := GtCoderToSpawn new coder: aPackageCoder.
	anEvent currentTarget fireEvent: aCoderEvent.
	aCoderEvent isConsumed
		ifFalse: [ anEvent currentTarget phlow spawnTool: (GtReadyCoderTool coder: aCoderEvent coder) ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPackageDefinition >> newTabFrom: anEvent [
	| aRealPackage aPackageCoder aSpace |
	aRealPackage := self packageOrganizer
			packageNamed: self name
			ifAbsent: [ ^ self ].

	aPackageCoder := GtCoderElement forPackage: aRealPackage.

	aSpace := BlSpace new.
	aSpace title: self name.
	aSpace icon: BrGlamorousVectorIcons emphasizedBrowse.
	aSpace extent: 1200 @ 600.
	aSpace root background: Color transparent.
	aSpace inPager: aPackageCoder.
	aSpace withCommonSettings.
	aSpace showFrom: anEvent target
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPackageDefinition >> packageReader [
	^ GtCodeDefinitionSingleReader new
		title: 'Package';
		definition: self;
		getSelector: #name;
		renameEvent: GtBehaviorPackageRenamed;
		whenAltClickDo: [ :anEvent :aDefinition | aDefinition replaceFrom: anEvent ];
		whenPrimaryClickDo: [ :anEvent :aDefinition | aDefinition newTabFrom: anEvent ];
		whenClickDo: [ :anEvent :aDefinition | aDefinition browseFrom: anEvent ];
		when: BlKeyUpEvent do: [ :anEvent | anEvent target mouseCursor: nil ];
		when: BlKeyDownEvent
			do: [ :anEvent | 
				anEvent consumed: true.
				anEvent key isAlt
					ifTrue: [ anEvent target mouseCursor: BlAliasCursor new ]
					ifFalse: [ anEvent key isPrimary
							ifTrue: [ anEvent target mouseCursor: BlCopyCursor new ]
							ifFalse: [ anEvent target mouseCursor: nil ] ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPackageDefinition >> readers [
	^ { self packageReader }
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPackageDefinition >> replaceFrom: anEvent [
	| aRealPackage aCoderEvent aPackageCoder |

	aRealPackage := self packageOrganizer
		packageNamed: self name
		ifAbsent: [ ^ self ].

	aPackageCoder := GtPharoPackageCoder forPackage: aRealPackage.
	aCoderEvent := GtCoderToReplace new coder: aPackageCoder.
	anEvent currentTarget fireEvent: aCoderEvent.
	aCoderEvent isConsumed
		ifFalse: [ anEvent currentTarget phlow spawnTool: (GtReadyCoderTool coder: aCoderEvent coder) ]
]
