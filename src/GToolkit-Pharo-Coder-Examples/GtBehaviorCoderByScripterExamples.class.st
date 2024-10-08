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
			aStep
				clickStep: [ :s | 
					s
						label: 'Click add method button';
						id: GtPharoAddNewMethodButtonId ] ].

	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_click_expand_definition [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI.

	aScripter
		substep: 'Expand class definition'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click expand class definition';
						id: GtSourceCoderExpanderToggleId ] ].
	^ aScripter
]

{ #category : #'examples - for class' }
GtBehaviorCoderByScripterExamples >> classCoderForClassUI_click_slot [
	<gtExample>
	| aScripter |
	aScripter := self classCoderForClassUI_click_expand_definition.
	aScripter
		substep: ''
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						// (GtMagritteFieldElementId new description: GtBehaviorCreationForm new slotsDescription) ] ].

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
			aStep
				clickStep: [ :s | 
					s
						label: 'Click class name';
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name has focus';
						satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep shortcut
				combination: BlKeyCombination primaryC;
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert clipboard has class name';
						value: [ Clipboard clipboardText ]
							equals: [ :aCoder | (aCoder attributeNamed: #dummyClass) className ];
						onModel ] ].

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

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name has focus';
						satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name is editable';
						satisfies: [ :aClassNameEditor | aClassNameEditor isEditable ];
						id: GtBehaviorCoderBehaviorNameId ] ].

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
			aStep
				clickStep: [ :s | 
					s
						label: 'Click class name';
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name has focus';
						satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep shortcut
				combination: BlKeyCombination primaryR;
				id: GtBehaviorCoderBehaviorNameId;
				play.

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name is editable';
						satisfies: [ :aClassNameEditor | aClassNameEditor isEditable ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name has focus';
						satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
						id: GtBehaviorCoderBehaviorNameId ] ].

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
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert apply preview button does not exist yet';
						notExists;
						id: GtBehaviorCoderBehaviorNameApplyPreviewId ].

			(aStep type: (aScripter model attributeNamed: #dummyClass) className , 'New')
				label: 'Click class name';
				play.

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name has focus';
						satisfies: [ :aClassNameEditor | aClassNameEditor hasFocus ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert class name is editable';
						satisfies: [ :aClassNameEditor | aClassNameEditor isEditable ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert entered name';
						value: [ :aClassNameEditor | aClassNameEditor text asString ]
							equals: [ (aScripter model attributeNamed: #dummyClass) className , 'New' ];
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert apply preview button exists not';
						exists;
						id: GtBehaviorCoderBehaviorNameApplyPreviewId ] ].

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
			aStep
				clickStep: [ :s | 
					s
						label: 'Click apply preview button';
						id: GtBehaviorCoderBehaviorNameApplyPreviewId ] ].

	^ aScripter
]

{ #category : #utilities }
GtBehaviorCoderByScripterExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ]
]
