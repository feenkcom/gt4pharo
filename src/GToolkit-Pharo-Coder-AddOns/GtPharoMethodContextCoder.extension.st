Extension { #name : #GtPharoMethodContextCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodContextCoder >> actionsForPragmas: aSymbolsCollection [
	^ self session class debuggingActionsForPragmas: aSymbolsCollection for: self
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodContextCoder >> addDebuggerContextMenuAddOnsAst: anAst to: coderAddOns [
	<gtCoderContextMenuAddOns: 10>
	| theActions classes aPriority |
	classes := {ResumeDebugAction.
			RestartDebugAction.
			StepOverDebugAction.
			StepIntoDebugAction.
			StepThroughDebugAction.
			GtRunToSelectionDebugAction}.

	aPriority := 10.
	theActions := ((classes
			collect: [ :each | each gt2ContextDebuggingActionFor: nil ])
			select: [ :aDebuggingAction "Quite hacky solutions for only showing StepInto for the top context." | 
				aDebuggingAction class ~= StepIntoDebugAction
					or: [ self context = self session interruptedContext ] ])
			collect: [ :aDebuggingAction | 
				GtCoderAction new
					priority: (aPriority := aPriority + 0.001);
					title: aDebuggingAction label;
					icon: (aDebuggingAction icon ifNil: [ BlElement new size: 0 @ 0 ]);
					action: [ :viewModel :element | 
						element
							withAllParentsDetect: [ :each | each isKindOf: GtDebuggerElement ]
							ifFound: [ :dbg | 
								aDebuggingAction
									debugger: dbg;
									execute ]
							ifNone: [  ] ];
					shortcutKey: aDebuggingAction keymap ].

	coderAddOns addContextMenuActions: theActions
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodContextCoder >> exampleFailureStylerFor: anAST into: coderAddOns viewModel: aGtPharoMethodCoderViewModel [ 
	coderAddOns addStyler: (GtCoderExampleFailureStyler new
		styleBlock: [ :aText :aColor | aText underlineColor: aColor thickness: 3 ]).
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodContextCoder >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.
	
	addOns addShortcut: GtSourceCoderPrintItShortcut new
]
