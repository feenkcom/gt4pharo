Class {
	#name : #GtBehaviorCoderByScripterExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#instVars : [
		'environment'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClass [
	<gtExample>
	<after: #cleanUp>
	| aDummyClass aBehaviorCoder |
	
	environment := GtPharoDummyEnvironment withPackages: 2 classes: 2.
	aDummyClass := environment anyDummyClass.

	aBehaviorCoder := GtPharoBehaviorCoder forClass: aDummyClass realClass.
	aBehaviorCoder attributeNamed: #dummyEnvironment put: environment.
	aBehaviorCoder attributeNamed: #dummyClass put: aDummyClass.

	^ aBehaviorCoder
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI [
	<gtExample>
	| aScripter |

	aScripter := self scripterForBlock: [ self classCoderForClass ].
	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_click_add_method [
	<gtExample>
	| aScripter |

	aScripter := self classCoderForClassUI.
	
	aScripter
		substep: 'Add new method'
		do: [ :aStep |
			aStep click
				label: 'Click add method button';
				id: GtPharoBehaviorCoder addNewMethodButtonName;
				play.
	 ].	

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_copyClassName [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI.

	aScripter
		substep: 'Copy class name with a shortcut'
		do: [ :aStep | 
			aStep click
				label: 'Click class name';
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep assert
				label: 'Assert class name has focus';
				satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep shortcut
				combination: BlKeyCombination primaryC;
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep assert
				label: 'Assert clipboard has class name';
				value: [ Clipboard clipboardText ]
					equals: [ :aCoder | (aCoder attributeNamed: #dummyClass) className ];
				onModel;
				play ].

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_renameClass_01_doubleClick [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI.

	aScripter
		substep: 'Make class name editable with a double click'
		do: [ :aStep | 
			aStep doubleClick
				label: 'Click class name';
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep assert
				label: 'Assert class name has focus';
				satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep assert
				label: 'Assert class name is editable';
				satisfies: [ :aClassNameEditor | aClassNameEditor isEditable ];
				id: GtBehaviorCoderBehaviorNameId;
				play ].

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_renameClass_01_shortcut [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI.

	aScripter
		substep: 'Make class name editable with a shortcut'
		do: [ :aStep | 
			aStep click
				label: 'Click class name';
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep assert
				label: 'Assert class name has focus';
				satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep shortcut
				combination: BlKeyCombination primaryR;
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep assert
				label: 'Assert class name is editable';
				satisfies: [ :aClassNameEditor | aClassNameEditor isEditable ];
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep assert
				label: 'Assert class name has focus';
				satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
				id: GtBehaviorCoderBehaviorNameId;
				play ].

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_renameClass_02_type_new_class_name [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI_renameClass_01_shortcut.

	aScripter
		substep: 'Type new class name'
		do: [ :aStep | 
			aStep assert
				label: 'Assert apply preview button does not exist yet';
				notExists;
				id: GtBehaviorCoderBehaviorNameApplyPreviewId;
				play.

			(aStep type: (aScripter model attributeNamed: #dummyClass) className , 'New')
				label: 'Click class name';
				play.

			aStep assert
				label: 'Assert class name has focus';
				satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep assert
				label: 'Assert class name is editable';
				satisfies: [ :aClassNameEditor | aClassNameEditor isEditable ];
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep assert
				label: 'Assert entered name';
				value: [ :aClassNameEditor | aClassNameEditor text asString ]
					equals: [ (aScripter model attributeNamed: #dummyClass) className , 'New' ];
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep assert
				label: 'Assert apply preview button exists not';
				exists;
				id: GtBehaviorCoderBehaviorNameApplyPreviewId;
				play ].

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_renameClass_03_click_rename_preview [
	<gtExample>
	| aScripter |

	aScripter := self classCoderForClassUI_renameClass_02_type_new_class_name.
	
	aScripter
		substep: 'Click rename preview'
		do: [ :aStep |
			
			aStep click
				label: 'Click apply preview button';
				id: GtBehaviorCoderBehaviorNameApplyPreviewId;
				play.
	].
		
	^ aScripter
]

{ #category : #utilities }
GtBehaviorCoderByScripterExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ]
]
