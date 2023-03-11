Class {
	#name : #GtCreateBehaviorElementByScripterExamples,
	#superclass : #GtCoderByScripterExamples,
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #'examples - instance creation' }
GtCreateBehaviorElementByScripterExamples >> behaviorCreatorForClass [
	<gtExample>
	
	^ GtPharoCreateBehaviorElement new
		forClassDefinition;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ]
]

{ #category : #'examples - class creator' }
GtCreateBehaviorElementByScripterExamples >> checkDefaultCreatorForClass [
	<gtExample>
	| aScripter |
	
	aScripter := self scripterForClass.
	
	aScripter substep: 'Check initial state of the class creator' do: [ :aStep | 
		aStep assert
			label: 'Assert default new class name';
			value: [ :aNameEditor | aNameEditor text asString ] equals: 'NameOfSubclass';
			id: GtCodeDefinition behaviorNameEditorName;
			play.
	
		aStep assert
			label: 'Assert default superclass name';
			value: [ :aNameEditor | aNameEditor text asString ] equals: 'Object';
			id: GtCodeDefinition behaviorSuperclassEditorName;
			play.
			
		aStep assert
			label: 'Assert default package name';
			value: [ :aNameEditor | aNameEditor text asString ] equals: '';
			id: GtCodeDefinition packageEditorName;
			play.
			
		aStep assert
			label: 'Assert default tag name';
			value: [ :aNameEditor | aNameEditor text asString ] equals: '';
			id: GtCodeDefinition tagEditorName;
			play.
			
		aStep assert
			label: 'Assert default traits';
			value: [ :aTagger | aTagger tagNames asArray ] equals: #();
			id: GtCodeDefinition traitsEditorName;
			play.
			
		aStep assert
			label: 'Assert default slots';
			value: [ :aTagger | aTagger tagNames asArray ] equals: #();
			id: GtCodeDefinition slotsEditorName;
			play.
			
		aStep assert
			label: 'Assert default class variables';
			value: [ :aTagger | aTagger tagNames asArray ] equals: #();
			id: GtCodeDefinition classVariablesEditorName;
			play.
			
		aStep assert
			label: 'Assert default shared pools';
			value: [ :aTagger | aTagger tagNames asArray ] equals: #();
			id: GtCodeDefinition poolsEditorName;
			play.

		aStep assert
			label: 'Assert save button is disabled';
			satisfies: [ :aButton | aButton isDisabled ];
			id: GtPharoCreateBehaviorElement saveButtonName ;
			play ].

	^ aScripter
]

{ #category : #'private - checks' }
GtCreateBehaviorElementByScripterExamples >> classExists: aClassName [
	^ self class environment includesKey: aClassName
]

{ #category : #'private - checks' }
GtCreateBehaviorElementByScripterExamples >> classNamed: aClassName [
	^ self class environment at: aClassName
]

{ #category : #'private - setup' }
GtCreateBehaviorElementByScripterExamples >> cleanUp [
	<script: 'self new cleanUp'>
	
	self class environment
		at: self newClassName
		ifPresent: [ :aClass | GtPharoCodeModifier removeBehavior: aClass ].
	
	GtPharoCodeModifier removeBehaviorNamed: self newPackageName
]

{ #category : #'private - setup' }
GtCreateBehaviorElementByScripterExamples >> newClassName [
	^ #GtCreateBehaviorElementByScripterNewClass
]

{ #category : #'private - setup' }
GtCreateBehaviorElementByScripterExamples >> newPackageName [
	^ #'GtCreateBehaviorElementByScripterNew-Package'
]

{ #category : #'private - setup' }
GtCreateBehaviorElementByScripterExamples >> newTagName [
	^ #'Tag'
]

{ #category : #'examples - class creator' }
GtCreateBehaviorElementByScripterExamples >> saveClassWithName [
	<gtExample>
	<after: #cleanUp>
	| aScripter |

	aScripter := self typeNewClassNameForClass.
	
	aScripter substep: 'Save class with just name' do: [ :aStep | 
		aStep click
			id: GtPharoCreateBehaviorElement saveButtonName;
			play.
		
		aStep assert
			label: 'New class does not exist';
			satisfies: [ (self classExists: self newClassName) not ];
			onScripter;
			play.
	].

	^ aScripter
]

{ #category : #'examples - class creator' }
GtCreateBehaviorElementByScripterExamples >> saveClassWithNamePackage [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self typeNewClassNamePackageForClass.

	aScripter
		substep: 'Save class with name and package'
		do: [ :aStep | 
			aStep click
				id: GtPharoCreateBehaviorElement saveButtonName;
				play.

			aStep assert
				label: 'New class exists';
				satisfies: [ self classExists: self newClassName ];
				onScripter;
				play.

			aStep set
				label: 'Set new class definition as model';
				model: [ GtBehaviorDefinition fromBehavior: (self classNamed: self newClassName) ];
				play.

			aStep assert
				label: 'Assert class name';
				value: [ :aDefinition | aDefinition name ] equals: self newClassName;
				onModel;
				play.

			aStep assert
				label: 'Assert superclass name';
				value: [ :aDefinition | aDefinition instanceSideDefinition superclass name ]
					equals: 'Object';
				onModel;
				play.

			aStep assert
				label: 'Assert package name';
				value: [ :aDefinition | aDefinition instanceSideDefinition category package name ]
					equals: self newPackageName;
				onModel;
				play.

			aStep assert
				label: 'Assert tag name';
				value: [ :aDefinition | aDefinition instanceSideDefinition category tag name ]
					equals: '';
				onModel;
				play ].

	^ aScripter
]

{ #category : #'examples - class creator' }
GtCreateBehaviorElementByScripterExamples >> saveClassWithNamePackageTag [
	<gtExample>
	<after: #cleanUp>
	| aScripter |
	aScripter := self typeNewClassNamePackageTagForClass.

	aScripter
		substep: 'Save class with name, package and tag'
		do: [ :aStep | 
			aStep click
				id: GtPharoCreateBehaviorElement saveButtonName;
				play.

			aStep assert
				label: 'New class exists';
				satisfies: [ self classExists: self newClassName ];
				onScripter;
				play.

			aStep set
				label: 'Set new class definition as model';
				model: [ GtBehaviorDefinition fromBehavior: (self classNamed: self newClassName) ];
				play.

			aStep assert
				label: 'Assert class name';
				value: [ :aDefinition | aDefinition name ] equals: self newClassName;
				onModel;
				play.

			aStep assert
				label: 'Assert superclass name';
				value: [ :aDefinition | aDefinition instanceSideDefinition superclass name ]
					equals: 'Object';
				onModel;
				play.

			aStep assert
				label: 'Assert package name';
				value: [ :aDefinition | aDefinition instanceSideDefinition category package name ]
					equals: self newPackageName;
				onModel;
				play.

			aStep assert
				label: 'Assert tag name';
				value: [ :aDefinition | aDefinition instanceSideDefinition category tag name ]
					equals: self newTagName;
				onModel;
				play ].

	^ aScripter
]

{ #category : #'examples - instance creation' }
GtCreateBehaviorElementByScripterExamples >> scripterForClass [
	<gtExample>
	| aScripter |
	
	self cleanUp.
	aScripter := self scripter.
	aScripter element: self behaviorCreatorForClass.

	^ aScripter
]

{ #category : #'examples - class creator' }
GtCreateBehaviorElementByScripterExamples >> typeNewClassNameForClass [
	<gtExample>
	| aScripter |
	aScripter := self checkDefaultCreatorForClass.

	aScripter
		substep: 'Type new class name'
		do: [ :aStep | 
			aStep click
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			aStep assert
				label: 'Assert class name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor hasFocus ];
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			aStep assert
				label: 'Assert class name editor is readonly';
				satisfies: [ :aNameEditor | aNameEditor isReadOnly ];
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			(aStep keyPress: BlKeyboardKey return) play.

			aStep assert
				label: 'Assert class name editor is in editable mode';
				satisfies: [ :aNameEditor | aNameEditor isEditable ];
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			aStep type
				text: self newClassName;
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			aStep assert
				label: 'Assert typed new class name';
				value: [ :aNameEditor | aNameEditor text asString ]
					equals: self newClassName;
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			(aStep keyPress: BlKeyboardKey return) play.

			aStep assert
				label: 'Assert class name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor hasFocus ];
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			aStep assert
				label: 'Assert class name editor is readonly';
				satisfies: [ :aNameEditor | aNameEditor isReadOnly ];
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			(aStep keyPress: BlKeyboardKey escape) play.

			aStep assert
				label: 'Assert class name editor does not have focus';
				satisfies: [ :aNameEditor | aNameEditor hasFocus not ];
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			aStep assert
				label: 'Assert save button is disabled';
				satisfies: [ :aButton | aButton isDisabled ];
				id: GtPharoCreateBehaviorElement saveButtonName;
				play ].

	^ aScripter
]

{ #category : #'examples - class creator' }
GtCreateBehaviorElementByScripterExamples >> typeNewClassNamePackageForClass [
	<gtExample>
	| aScripter |
	aScripter := self typeNewClassNameForClass.

	aScripter
		substep: 'Type new package name'
		do: [ :aStep | 
			aStep click
				id: GtCodeDefinition packageEditorName;
				play.

			aStep assert
				label: 'Assert package name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor hasFocus ];
				id: GtCodeDefinition packageEditorName;
				play.

			aStep assert
				label: 'Assert package name editor is readonly';
				satisfies: [ :aNameEditor | aNameEditor isReadOnly ];
				id: GtCodeDefinition packageEditorName;
				play.

			(aStep keyPress: BlKeyboardKey return) play.
			aStep click
				id: GtCodeDefinition packageEditorName;
				play.

			aStep assert
				label: 'Assert package name editor is in editable mode';
				satisfies: [ :aNameEditor | aNameEditor isEditable ];
				id: GtCodeDefinition packageEditorName;
				play.

			aStep type
				text: self newPackageName;
				id: GtCodeDefinition packageEditorName;
				play.

			aStep assert
				label: 'Assert typed new package name';
				value: [ :aNameEditor | aNameEditor text asString ]
					equals: self newPackageName;
				id: GtCodeDefinition packageEditorName;
				play.

			(aStep keyPress: BlKeyboardKey return) play.

			aStep assert
				label: 'Assert package name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor hasFocus ];
				id: GtCodeDefinition packageEditorName;
				play.

			aStep assert
				label: 'Assert package name editor is readonly';
				satisfies: [ :aNameEditor | aNameEditor isReadOnly ];
				id: GtCodeDefinition packageEditorName;
				play.

			(aStep keyPress: BlKeyboardKey escape) play.

			aStep assert
				label: 'Assert package name editor does not have focus';
				satisfies: [ :aNameEditor | aNameEditor hasFocus not ];
				id: GtCodeDefinition packageEditorName;
				play.

			aStep assert
				label: 'Assert save button is enabled';
				satisfies: [ :aButton | aButton isEnabled ];
				id: GtPharoCreateBehaviorElement saveButtonName;
				play ].

	^ aScripter
]

{ #category : #'examples - class creator' }
GtCreateBehaviorElementByScripterExamples >> typeNewClassNamePackageTagForClass [
	<gtExample>
	| aScripter |
	aScripter := self typeNewClassNamePackageForClass.

	aScripter
		substep: 'Type new tag name'
		do: [ :aStep | 
			aStep click
				id: GtCodeDefinition tagEditorName;
				play.

			aStep assert
				label: 'Assert tag name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor hasFocus ];
				id: GtCodeDefinition tagEditorName;
				play.

			aStep assert
				label: 'Assert tag name editor is readonly';
				satisfies: [ :aNameEditor | aNameEditor isReadOnly ];
				id: GtCodeDefinition tagEditorName;
				play.

			(aStep keyPress: BlKeyboardKey return) play.
			aStep click
				id: GtCodeDefinition tagEditorName;
				play.

			aStep assert
				label: 'Assert tag name editor is in editable mode';
				satisfies: [ :aNameEditor | aNameEditor isEditable ];
				id: GtCodeDefinition tagEditorName;
				play.

			aStep type
				text: self newTagName;
				id: GtCodeDefinition tagEditorName;
				play.

			aStep assert
				label: 'Assert typed new tag name';
				value: [ :aNameEditor | aNameEditor text asString ] equals: self newTagName;
				id: GtCodeDefinition tagEditorName;
				play.

			(aStep keyPress: BlKeyboardKey return) play.

			aStep assert
				label: 'Assert tag name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor hasFocus ];
				id: GtCodeDefinition tagEditorName;
				play.

			aStep assert
				label: 'Assert tag name editor is readonly';
				satisfies: [ :aNameEditor | aNameEditor isReadOnly ];
				id: GtCodeDefinition tagEditorName;
				play.

			(aStep keyPress: BlKeyboardKey escape) play.

			aStep assert
				label: 'Assert tag name editor does not have focus';
				satisfies: [ :aNameEditor | aNameEditor hasFocus not ];
				id: GtCodeDefinition tagEditorName;
				play.

			aStep assert
				label: 'Assert save button is enabled';
				satisfies: [ :aButton | aButton isEnabled ];
				id: GtPharoCreateBehaviorElement saveButtonName;
				play ].

	^ aScripter
]

{ #category : #'examples - class creator' }
GtCreateBehaviorElementByScripterExamples >> typePackageNameForClass [
	<gtExample>
	| aScripter |
	aScripter := self checkDefaultCreatorForClass.

	aScripter
		substep: 'Type new class name'
		do: [ :aStep | 
			aStep click
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			aStep assert
				label: 'Assert class name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor hasFocus ];
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			aStep assert
				label: 'Assert class name editor is readonly';
				satisfies: [ :aNameEditor | aNameEditor isReadOnly ];
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			(aStep keyPress: BlKeyboardKey return) play.

			aStep assert
				label: 'Assert class name editor is in editable mode';
				satisfies: [ :aNameEditor | aNameEditor isEditable ];
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			aStep type
				text: self newClassName;
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			aStep assert
				label: 'Assert typed new class name';
				value: [ :aNameEditor | aNameEditor text asString ]
					equals: self newClassName;
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			(aStep keyPress: BlKeyboardKey return) play.

			aStep assert
				label: 'Assert class name editor has focus';
				satisfies: [ :aNameEditor | aNameEditor hasFocus ];
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			aStep assert
				label: 'Assert class name editor is readonly';
				satisfies: [ :aNameEditor | aNameEditor isReadOnly ];
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			(aStep keyPress: BlKeyboardKey escape) play.

			aStep assert
				label: 'Assert class name editor does not have focus';
				satisfies: [ :aNameEditor | aNameEditor hasFocus not ];
				id: GtCodeDefinition behaviorNameEditorName;
				play.

			aStep assert
				label: 'Assert save button is enabled';
				satisfies: [ :aButton | aButton isEnabled not ];
				id: GtPharoCreateBehaviorElement saveButtonName;
				play ].

	^ aScripter
]
