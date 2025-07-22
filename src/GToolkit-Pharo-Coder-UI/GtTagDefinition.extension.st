Extension { #name : #GtTagDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtTagDefinition >> browseFrom: anEvent [
	| aRealPackage |

	aRealPackage := self packageOrganizer
		packageNamed: self parent category package name
		ifAbsent: [ ^ self ].

	aRealPackage
		classTagNamed: self name
		ifPresent: [ :aTag |
			| aPackageTagCoder aCoderEvent |
			aPackageTagCoder := (GtPharoPackageTagCoder forPackageTag: aTag)
				packageCoder: (GtPharoPackageCoder forPackage: aRealPackage).
			aCoderEvent := GtCoderToSpawn new coder: aPackageTagCoder.
			anEvent currentTarget fireEvent: aCoderEvent.
			aCoderEvent isConsumed
				ifFalse: [ anEvent currentTarget phlow spawnTool: (GtReadyCoderTool coder: aCoderEvent coder) ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtTagDefinition >> newTabFrom: anEvent [
	| aRealPackage |
	aRealPackage := self packageOrganizer
			packageNamed: self parent category package name
			ifAbsent: [ ^ self ].

	aRealPackage
		classTagNamed: self name
		ifPresent: [ :aTag | 
			| aPackageTagCoder aSpace |
			aPackageTagCoder := GtCoderElement forPackageTag: aTag.


			aSpace := BlSpace new.
			aSpace title: self name.
			aSpace icon: BrGlamorousVectorIcons emphasizedBrowse.
			aSpace extent: 1200 @ 600.
			aSpace root background: Color transparent.
			aSpace
				addChild: (GtPager
						createOn: (GtPagerWrapperElement new
								tool: aPackageTagCoder;
								embellisher: (GtPagerPageEmbellisher new extension: GtPagerPageEmbellisherExtension null))).
			aSpace withHalos.
			anEvent target showSpace: aSpace ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtTagDefinition >> readers [
	^ { self tagReader }
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtTagDefinition >> replaceFrom: anEvent [
	| aRealPackage |

	aRealPackage := self packageOrganizer
		packageNamed: self parent category package name
		ifAbsent: [ ^ self ].

	aRealPackage
		classTagNamed: self name
		ifPresent: [ :aTag |
			| aPackageTagCoder aCoderEvent |
			aPackageTagCoder := (GtPharoPackageTagCoder forPackageTag: aTag)
				packageCoder: (GtPharoPackageCoder forPackage: aRealPackage).
			aCoderEvent := GtCoderToReplace new coder: aPackageTagCoder.
			anEvent currentTarget fireEvent: aCoderEvent.
			aCoderEvent isConsumed
				ifFalse: [ anEvent currentTarget phlow spawnTool: (GtReadyCoderTool coder: aCoderEvent coder) ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtTagDefinition >> tagReader [
	^ GtCodeDefinitionSingleReader new
		title: 'Tag';
		definition: self;
		getSelector: #name;
		renameEvent: GtBehaviorTagRenamed;
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
