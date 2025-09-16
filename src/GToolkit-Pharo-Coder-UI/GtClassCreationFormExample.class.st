Class {
	#name : #GtClassCreationFormExample,
	#superclass : #GtCreationFormExample,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtClassCreationFormExample >> classWithTwoTraitsDefinitionString [
	^ 'Object subclass: #ExampleClass uses: TGtPharoDummyTraitOne + TGtPharoDummyTraitTwo instanceVariableNames: '''' classVariableNames: '''' poolDictionaries: '''' category: ''ExamplePackage'''
]

{ #category : #accessing }
GtClassCreationFormExample >> exampleClassName [
	^ 'ExampleClass'
]

{ #category : #accessing }
GtClassCreationFormExample >> exampleClassNameWithUnderscore [
	^ 'Example_Class'
]

{ #category : #accessing }
GtClassCreationFormExample >> examplePackageName [
	^ 'ExamplePackage'
]

{ #category : #accessing }
GtClassCreationFormExample >> examplePackageNameWithDash [
	^ 'ExamplePackage-PartA'
]

{ #category : #accessing }
GtClassCreationFormExample >> examplePackageTagName [
	^ 'ExampleTag'
]

{ #category : #accessing }
GtClassCreationFormExample >> examplePackageTagNameWithDash [
	^ 'ExampleTag-PartB'
]

{ #category : #accessing }
GtClassCreationFormExample >> formClass [
	^ GtClassCreationForm
]

{ #category : #'tear down' }
GtClassCreationFormExample >> removeClassAndPackage [
	Smalltalk removeClassNamed: self exampleClassName.
	
	{self examplePackageName. self examplePackageNameWithDash} do: [ :aPackageName |
		self packageOrganizer  
			packageNamed:  aPackageName
			ifPresent: [ :aPackage |
				aPackage removeFromSystem ] ]
]

{ #category : #'examples - scripter' }
GtClassCreationFormExample >> scripterOnSimpleForm [
	<gtExample>
	| scripter |
	scripter := self scripterWithModel: [ self simpleForm ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Check save button is disabled';
				satisfies: [ :aForm | ((aForm childNamed: #toolbar) childAt: 1) isEnabled not ] ].

	^ scripter
]

{ #category : #'examples - scripter' }
GtClassCreationFormExample >> scripterWithClassAccepted [
	<gtExample>
	<after: #removeClassAndPackage>
	| scripter createdClass |
	scripter := self scripterWithClassNameAndPackageFilled.

	scripter
		clickStep: [ :s | 
			s
				label: 'Click save button';
				// #toolbar;
				onChildAt: 1 ].

	createdClass := Smalltalk classNamed: self exampleClassName.
	self assert: createdClass isNotNil.
	self assert: createdClass package name equals: self examplePackageName.
	self assert: createdClass packageTag isRoot.
	self assert: createdClass category equals: self examplePackageName.

	^ scripter
]

{ #category : #'examples - scripter' }
GtClassCreationFormExample >> scripterWithClassAcceptedWithPackageAndTag [
	<gtExample>
	<after: #removeClassAndPackage>
	| scripter createdClass | 
	scripter := self scripterWithClassNamePackageFilledAndTagFilled.
	
	self assert: (self packageOrganizer 
		packageMatchingExtensionName: self examplePackageName) isNil.

	self 
		assert: (self packageOrganizer  
			includesPackageNamed: self examplePackageName) not
		description: 'We assume the target package is not present in the system'.
self 
		assert: (self packageOrganizer  
			includesPackageNamed: ((self examplePackageName
				, '-'
				,self examplePackageTagName) asSymbol)) not
		description: 'We assume there is no package with the package-tag combination from this test in the system'.
		
	scripter
		clickStep: [ :s | 
			s
				label: 'Click save button';
				// #toolbar;
				onChildAt: 1 ].

	createdClass := Smalltalk classNamed: self exampleClassName.
	self assert: createdClass isNotNil.
	self assert: createdClass package name equals: self examplePackageName.
	self assert: createdClass packageTag name equals: self examplePackageTagName.
	self 
		assert: createdClass category 
		equals: (self examplePackageName, '-',self examplePackageTagName) asSymbol.

	^ scripter
]

{ #category : #'examples - scripter' }
GtClassCreationFormExample >> scripterWithClassAcceptedWithPackageAndTagWithDashInBothNames [
	<gtExample>
	<after: #removeClassAndPackage>
	| scripter createdClass | 
	scripter := self scripterWithClassNamePackageFilledAndTagFilledWithDashName.

	self assert: (self packageOrganizer 
		packageMatchingExtensionName: self examplePackageName) isNil.
	self 
		assert: (self packageOrganizer  
			includesPackageNamed: self examplePackageNameWithDash) not
		description: 'We assume the target package is not present in the system'.
self 
		assert: (self packageOrganizer  
			includesPackageNamed: ((self examplePackageNameWithDash
				, '-'
				,self examplePackageTagNameWithDash) asSymbol)) not
		description: 'We assume there is not package with the package-tag combination from this test in the system'.
	
	scripter
		clickStep: [ :s | 
			s
				label: 'Click save button';
				// #toolbar;
				onChildAt: 1 ].

	createdClass := Smalltalk classNamed: self exampleClassName.
	self assert: createdClass isNotNil.
	self assert: createdClass package name equals: self examplePackageNameWithDash.
	self assert: createdClass packageTag name equals: self examplePackageTagNameWithDash.
	self 
		assert: createdClass category 
		equals: (self examplePackageNameWithDash, '-',self examplePackageTagNameWithDash) asSymbol.

	^ scripter
]

{ #category : #'examples - scripter' }
GtClassCreationFormExample >> scripterWithClassNameAndPackageFilled [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterWithClassNameFilled.
	aDescription := scripter model packageAndTagDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	scripter requestFocus
		label: 'Focus package editor';
		// anElementId;
		onChildAt: 1;
		play.

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill package name';
				text: self examplePackageName;
				// anElementId;
				onChildAt: 1 ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Check that package is set';
				satisfies: [ :aFrame | 
					((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil
						currentValue packageName = self examplePackageName ] ].

	^ scripter
]

{ #category : #'examples - scripter' }
GtClassCreationFormExample >> scripterWithClassNameFilled [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterOnSimpleForm.
	aDescription := scripter model nameDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	scripter requestFocus
		label: 'Focus name editor';
		// anElementId;
		play.

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill class name';
				text: self exampleClassName;
				// anElementId ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Assert class name';
				value: [ :anEditor | anEditor text asString ]
					equals: [ self exampleClassName ];
				// anElementId ].

	^ scripter
]

{ #category : #'examples - scripter' }
GtClassCreationFormExample >> scripterWithClassNameFilledIncludingUnderscore [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterOnSimpleForm.
	aDescription := scripter model nameDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	scripter requestFocus
		label: 'Focus name editor';
		// anElementId;
		play.

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill class name';
				text: self exampleClassNameWithUnderscore;
				// anElementId ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Assert class name';
				value: [ :anEditor | anEditor text asString ]
					equals: [ self exampleClassNameWithUnderscore ];
				// anElementId ].

	^ scripter
]

{ #category : #'examples - scripter' }
GtClassCreationFormExample >> scripterWithClassNameFilledValidationFailed [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterOnSimpleForm.
	aDescription := scripter model nameDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	scripter requestFocus
		label: 'Focus name editor';
		// anElementId;
		play.

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill class name';
				text: 'Object';
				// anElementId ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Check that class name is invalid';
				satisfies: [ :aFrame | ((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil isValid not ] ].

	^ scripter
]

{ #category : #'examples - scripter' }
GtClassCreationFormExample >> scripterWithClassNamePackageAndTwoConflictingTraitsFilled [
	<gtExample>
	| scripter aDescription aFieldElementId aValidatorElementId |
	scripter := self scripterWithClassNameAndPackageFilled.
	aDescription := scripter model traitsDescription.
	aFieldElementId := GtMagritteFieldElementId new description: aDescription.
	aValidatorElementId := GtMagritteValidatorElementId new description: aDescription.

	scripter click
		label: 'Add Trait';
		// aFieldElementId;
		onChildAt: 1;
		play.

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill Trait name';
				text: TGtPharoDummyTraitOne name;
				// aFieldElementId;
				onChildAt: 1 ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Assert that Trait is set';
				satisfies: [ :aFrame | 
					((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil
						currentValue = {TGtPharoDummyTraitOne name} ] ].

	scripter
		shortcutStep: [ :s | 
			s
				label: 'Next Trait';
				combination: BlKeyCombination tab;
				// aFieldElementId;
				/ #tags;
				onChildAt: 1 ].

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill Trait name';
				text: TGtPharoDummyTraitThree name;
				// aFieldElementId;
				/ #tags;
				onChildAt: 2 ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Assert that both Traits are set';
				satisfies: [ :aFrame | 
					((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil
						currentValue
						= {TGtPharoDummyTraitOne name.
								TGtPharoDummyTraitThree name} ] ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Assert conflicting Traits message';
				value: [ :anEditor | anEditor text asString ] equals: 'Conflicting Traits';
				// aValidatorElementId;
				// GtMagritteIssuesExplanationId ].

	^ scripter
]

{ #category : #'examples - scripter' }
GtClassCreationFormExample >> scripterWithClassNamePackageAndTwoTraitsFilled [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterWithClassNameAndPackageFilled.
	aDescription := scripter model traitsDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	scripter click
		label: 'Add Trait';
		// anElementId;
		onChildAt: 1;
		play.

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill Trait name';
				text: TGtPharoDummyTraitOne name;
				// anElementId;
				onChildAt: 1 ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Assert that Trait is set';
				satisfies: [ :aFrame | 
					((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil
						currentValue = {TGtPharoDummyTraitOne name} ] ].

	scripter
		shortcutStep: [ :s | 
			s
				label: 'Next Trait';
				combination: BlKeyCombination tab;
				// anElementId;
				/ #tags;
				onChildAt: 1 ].

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill Trait name';
				text: TGtPharoDummyTraitTwo name;
				// anElementId;
				/ #tags;
				onChildAt: 2 ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Assert that both Traits are set';
				satisfies: [ :aFrame | 
					((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil
						currentValue
						= {TGtPharoDummyTraitOne name.
								TGtPharoDummyTraitTwo name} ] ].

	scripter
		doStep: [ :s | 
			s
				label: 'Accept form changes (without defining a class)';
				block: [ :aFrame | (aFrame userData at: #gtmemento) commit ] ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Assert class code';
				value: [ :aModel | aModel classDefinitionString ]
					equals: self classWithTwoTraitsDefinitionString;
				onModel ].

	^ scripter
]

{ #category : #'examples - scripter' }
GtClassCreationFormExample >> scripterWithClassNamePackageFilledAndTagFilled [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterWithClassNameAndPackageFilled.
	aDescription := scripter model packageAndTagDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	scripter requestFocus
		label: 'Focus tag editor';
		// anElementId;
		/ #tag;
		play.

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill tag name';
				text: self examplePackageTagName;
				// anElementId;
				/ #tag ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Check that package tag is set';
				satisfies: [ :aFrame | 
					((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil
						currentValue tagName = self examplePackageTagName ] ].

	^ scripter
]

{ #category : #'examples - scripter' }
GtClassCreationFormExample >> scripterWithClassNamePackageFilledAndTagFilledWithDashName [
	<gtExample>
	| scripter aDescription anElementId |
	scripter := self scripterWithClassNameFilled.
	aDescription := scripter model packageAndTagDescription.
	anElementId := GtMagritteFieldElementId new description: aDescription.

	scripter requestFocus
		label: 'Focus package editor';
		// anElementId;
		/ #package;
		play.

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill package name';
				text: self examplePackageNameWithDash;
				// anElementId;
				/ #package ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Check that package is set';
				satisfies: [ :aFrame | 
					((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil
						currentValue packageName = self examplePackageNameWithDash ] ].
	
	scripter requestFocus
		label: 'Focus tag editor';
		// anElementId;
		/ #tag;
		play.

	scripter
		typeStep: [ :s | 
			s
				label: 'Fill tag name';
				text: self examplePackageTagNameWithDash;
				// anElementId;
				/ #tag ].

	scripter
		assertStep: [ :s | 
			s
				label: 'Check that package tag is set';
				satisfies: [ :aFrame | 
					((aFrame userData at: #gtmemento) cache at: aDescription) valueOrNil
						currentValue tagName = self examplePackageTagNameWithDash ] ].

	^ scripter
]

{ #category : #accessing }
GtClassCreationFormExample >> simpleForm [
	^ self formClass new
]
