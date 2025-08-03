Extension { #name : #GtClassSuperclassDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassSuperclassDefinition >> browseFrom: anEvent [
	self class environment
		at: self name
		ifPresent: [ :aClass |
			| aCoderEvent aClassCoder |

			aClassCoder := GtPharoBehaviorCoder forClass: aClass.
			aCoderEvent := GtCoderToSpawn new coder: aClassCoder.
			anEvent currentTarget fireEvent: aCoderEvent.
			aCoderEvent isConsumed
				ifFalse: [ anEvent currentTarget phlow spawnTool: (GtReadyCoderTool coder: aCoderEvent coder) ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassSuperclassDefinition >> browseReferencesFrom: anEvent [
	self class environment
		at: self name
		ifPresent:
			[ :class | anEvent currentTarget phlow spawnObject: class gtReferences ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassSuperclassDefinition >> newTabFrom: anEvent [
	self class environment
		at: self name
		ifPresent: [ :aClass | 
			| aSpace |
			
			aSpace := BlSpace new.
			aSpace title: self name.
			aSpace icon: BrGlamorousVectorIcons emphasizedBrowse.
			aSpace extent: 1200 @ 600.
			aSpace root background: Color transparent.
			aSpace inPager: (GtClassCoderTool forClass: aClass).
			aSpace withSceneDriller.
			aSpace showFrom: anEvent target ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassSuperclassDefinition >> readers [
	^ { self superclassReader }
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassSuperclassDefinition >> replaceFrom: anEvent [
	self class environment
		at: self name
		ifPresent: [ :aClass |
			| aCoderEvent aClassCoder |
			aClassCoder := GtPharoBehaviorCoder forClass: aClass.
			aCoderEvent := GtCoderToReplace new coder: aClassCoder.
			anEvent currentTarget fireEvent: aCoderEvent.
			aCoderEvent isConsumed ifFalse: [ 
				anEvent currentTarget phlow spawnTool: (GtReadyCoderTool coder: aCoderEvent coder) ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassSuperclassDefinition >> superclassReader [
	<return: #GtCodeDefinitionViewer>
	^ GtCodeDefinitionSingleReader new
		definition: self;
		title: 'Superclass';
		getSelector: #name;
		renameEvent: GtBehaviorSuperclassRenamed;
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
