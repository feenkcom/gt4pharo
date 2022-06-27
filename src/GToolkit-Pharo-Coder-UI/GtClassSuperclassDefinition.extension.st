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
GtClassSuperclassDefinition >> editors [
	^ { self superclassEditor }
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassSuperclassDefinition >> newTabFrom: anEvent [
	self class environment
		at: self name
		ifPresent: [ :aClass | 
			| aClassCoder aSpace |
			aClassCoder := GtCoder forClass: aClass.

			aSpace := BlSpace new.
			aSpace title: self name.
			aSpace icon: BrGlamorousVectorIcons emphasizedBrowse.
			aSpace extent: 1200 @ 600.
			aSpace root background: Color transparent.
			aSpace
				addChild: (GtPager
						createOn: (GtPagerWrapperElement new
								tool: aClassCoder;
								embellisher: (GtPagerPageEmbellisher new extension: GtPagerPageEmbellisherExtension null))).
			aSpace withHalos.
			anEvent target showSpace: aSpace ]
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
GtClassSuperclassDefinition >> superclassEditor [
	<return: #GtCodeDefinitionViewer>
	
	^ GtCodeDefinitionSingleEditor new
			definition: self;
			title: 'Superclass';
			getSelector: #name;
			setSelector: #name:;
			renameEvent: GtBehaviorSuperclassRenamed;
			completion: [ GtClassesCompletionStrategy new ];
			whenKey: BlKeyCombination primaryB do: [ :anEvent :aDefinition  | 
				aDefinition browseFrom: anEvent ];
			whenKey: BlKeyCombination primaryN do: [ :anEvent :aDefinition  | 
				aDefinition browseReferencesFrom: anEvent ];
			whenPrimaryClickDo: [ :anEvent :aDefinition | 
				aDefinition browseFrom: anEvent ];
			whenKey: BlKeyCombination primaryC do: [ :anEvent :aDefinition  |
				Clipboard clipboardText: aDefinition name asString ];
		containerName: self class behaviorSuperclassEditorName
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
		whenClickDo: [ :anEvent :aDefinition | aDefinition browseFrom: anEvent ]
]
