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

	aScripter
		doStep: [ :s | 
			s
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
				// GtSourceCoderEditorId ].

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

	aScripter
		substeps: 'Open a method name refactoring preview dialog'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Change the space extent';
						block: [ :aSpace | aSpace extent: 910 @ 620 ];
						onSpace ].

			aStep shortcut
				label: 'Switch to the method name refactoring mode';
				combination: BlKeyCombination primaryR;
				// (GtSourceCoderId indexed: 3);
				// GtSourceCoderEditorId;
				// GtSourceCoderEditorInnerId;
				play.

			aStep
				typeStep: [ :s | 
					s
						label: 'Type a new method name';
						text: 'thisIsANewMethodName' ].

			aStep
				clickStep: [ :s | 
					s
						label: 'Open refactoring dialog';
						// (GtSourceCoderId indexed: 3);
						// GtSourceCoderEditorId;
						// #previewCheckButton ].

		"	aStep
				clickStep: [ :s | 
					s
						label: 'Expand the refactoring preview dropdown';
						onSpaceRoot;
						onDropdown: true;
						// GtChangesElement;
						// BrInlineExpanderElement ]."

			aStep
				doStep: [ :s | 
					s
						label: 'Setup dropdown overview';
						block: [ :aButton :aUserData | 
							aUserData
								at: BrAnchoredVisualAnalysis
								put: (BrAnchoredVisualAnalysis new elementWithDropdown: aButton) ];
						// (GtSourceCoderId indexed: 3);
						// GtSourceCoderEditorId;
						// #previewCheckButton ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert dropdown bounds';
						satisfies: [ :anAsyncWidget | anAsyncWidget space root boundsInSpace containsRect: anAsyncWidget boundsInSpace ]
							description: [ 'Refactoring preview bounds is out of space' ];
						onSpaceRoot;
						onDropdown: true;
						/ GtRefactoringsPreviewElement ] ].


	^ aScripter
]
