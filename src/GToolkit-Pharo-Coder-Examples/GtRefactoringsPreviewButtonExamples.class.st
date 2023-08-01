"
I exemplify {{gtClass: GtRefactoringsPreviewButton }}. 
"
Class {
	#name : #GtRefactoringsPreviewButtonExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Refactorings'
}

{ #category : #'examples - method coder' }
GtRefactoringsPreviewButtonExamples >> clickOnMethodSender [
	<gtExample>
	| aScripter |
	aScripter := self coderWithDummyMethod.

	aScripter do
		label: 'Move cursor to a method sender';
		block: [ :anEditorElement | 
			| aMethod aPosition |
			aMethod := anEditorElement textualCoderViewModel compiledMethod.
			self
				assert: aMethod
				equals: GtRefactoringsDummyClass >> #userOfThisIsALongMethodThatWillBeRefactored.

			aPosition := (GtRefactoringsDummyClass
					>> #userOfThisIsALongMethodThatWillBeRefactored) sourceCode
					findString: (GtRefactoringsDummyClass
							>> #thisIsALongMethodThatWillBeRefactored) selector
					startingAt: 1
					caseSensitive: true.

			anEditorElement editor deselecter
				all;
				deselect.
			anEditorElement editor moveCursorTo: aPosition + 1 ];
		// (GtSourceCoderId indexed: 3);
		// GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #'examples - method coder' }
GtRefactoringsPreviewButtonExamples >> coderWithDummyMethod [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithElement: [ GtCoderElement
					forMethod: GtRefactoringsDummyClass >> #userOfThisIsALongMethodThatWillBeRefactored ].

	^ aScripter
]

{ #category : #'examples - refactoring' }
GtRefactoringsPreviewButtonExamples >> switchToMethodNameRefactoringMode [
	<gtExample>
	| aScripter |
	aScripter := self clickOnMethodSender.
	
	aScripter substeps: 'Open a method name refactoring preview dialog' do: [ :aStep |
	
		aStep do
			label: 'Change the space extent';
			block: [ :aSpace | aSpace extent: 910 @ 620 ];
			onSpace;
			play.
	
		aStep shortcut
			label: 'Switch to the method name refactoring mode';
			combination: BlKeyCombination primaryR;
			// (GtSourceCoderId indexed: 3);
			// GtSourceCoderEditorId;
			play.
			
		aStep type
			label: 'Type a new method name';
			text: 'thisIsANewMethodName';
			play.
			
		aStep click
			label: 'Open refactoring dialog';
			// (GtSourceCoderId indexed: 3);
			// GtSourceCoderEditorId;
			// #previewCheckButton;
			play.
			
		aStep click 
			label: 'Expand the refactoring preview dropdown';
			onSpaceRoot;
			// BrAnchoredOuterContainer;
			// GtChangesElement;
			// BrTriangle;
			play.
			
		aStep do
			label: 'Setup dropdown overview';
			block: [ :aButton :aUserData | 
				aUserData at: BrAnchoredVisualAnalysis put: (
					BrAnchoredVisualAnalysis new
						elementWithDropdown: aButton) ];
			// (GtSourceCoderId indexed: 3);
			// GtSourceCoderEditorId;
			// #previewCheckButton;
			play.
			
		aStep assert
			label: 'Assert dropdown bounds';
			satisfies: [ :anAsyncWidget | 
				anAsyncWidget space root boundsInSpace containsRect: anAsyncWidget boundsInSpace ]
				description: [ 'Refactoring preview bounds is out of space' ];
			onSpaceRoot;
			// BrAnchoredOuterContainer;
			// BrAnchoredElement;
			/ #content;
			/ BrAsyncWidget;
			play ].
		

	^ aScripter
]
