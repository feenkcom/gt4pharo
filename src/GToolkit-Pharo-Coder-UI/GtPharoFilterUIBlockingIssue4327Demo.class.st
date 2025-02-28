"
I am used to demo UI blocking issues.
For more details, see [](https://github.com/feenkcom/gtoolkit/issues/4327). 

To install call {{gtMethod:GtPharoFilterUIBlockingIssue4327Demo class >> install}}: 
```smalltalk
GtPharoFilterUIBlockingIssue4327Demo install.
```

To experience *several minutes* UI blocking issue call:
```smalltalk
GtSearchMethodAdviceFilter new advice: GtMessageNotImplementedAdvice new.
```

To uninstall call {{gtMethod:GtPharoFilterUIBlockingIssue4327Demo class >> uninstall}}: 
```smalltalk
GtPharoFilterUIBlockingIssue4327Demo uninstall.
```

"
Class {
	#name : #GtPharoFilterUIBlockingIssue4327Demo,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#instVars : [
		'pragmaFilterLink',
		'elementLink'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Demo'
}

{ #category : #'api - demo' }
GtPharoFilterUIBlockingIssue4327Demo class >> install [
	^ self default install
]

{ #category : #'private - hooks' }
GtPharoFilterUIBlockingIssue4327Demo class >> onRemoveUniqueInstance: anInstance [
	"Classes may perform some activities on a singleton that is about to be released"

	anInstance uninstall
]

{ #category : #'api - demo' }
GtPharoFilterUIBlockingIssue4327Demo class >> uninstall [
	^ self default uninstall
]

{ #category : #'api - demo' }
GtPharoFilterUIBlockingIssue4327Demo >> install [
	self uninstall.
	self installPragmaFilterMetaLink.
	self installFilterElementMetaLink.
]

{ #category : #'api - demo' }
GtPharoFilterUIBlockingIssue4327Demo >> installFilterElementMetaLink [
	| aNode |
	self uninstallFilterElementMetaLink.
	aNode := (GtFilterShortListSettingsElement >> #updateListElement:) ast.
	elementLink := MetaLink new
			metaObject: [ :anElement :anArguments | 
				anElement updateListElementOldWay: anArguments first ];
			selector: #value:value:;
			arguments: #(receiver arguments);
			control: #instead.
	aNode link: elementLink.
]

{ #category : #'api - demo' }
GtPharoFilterUIBlockingIssue4327Demo >> installPragmaFilterMetaLink [
	| aNode |
	self uninstallPragmaFilterMetaLink.
	aNode := (GtSearchPragmasFilter class >> #filterDescriptor2For:) ast.
	pragmaFilterLink := MetaLink new
			metaObject: [ :aFilter :anArguments | 
				aFilter filterDescriptor2ForOldWay: anArguments first ];
			selector: #value:value:;
			arguments: #(receiver arguments);
			control: #instead.
	aNode link: pragmaFilterLink.
]

{ #category : #'api - demo' }
GtPharoFilterUIBlockingIssue4327Demo >> uninstall [
	self uninstallPragmaFilterMetaLink.
	self uninstallFilterElementMetaLink
]

{ #category : #'api - demo' }
GtPharoFilterUIBlockingIssue4327Demo >> uninstallFilterElementMetaLink [
	elementLink ifNotNil: #uninstall.
	elementLink := nil.
]

{ #category : #'api - demo' }
GtPharoFilterUIBlockingIssue4327Demo >> uninstallPragmaFilterMetaLink [
	pragmaFilterLink ifNotNil: #uninstall.
	pragmaFilterLink := nil.
]
