Extension { #name : #GtPharoTemplateMethodCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoTemplateMethodCoder >> initializeAddOns: addOns [
	super initializeAddOns: addOns.
	
	addOns addStyler: GtPharoStyler new.
	addOns addStyler: GtPharoDeprecationStyler new.
	addOns addStyler: GtPharoMethodExpanderStyler new.

	"addOns
		addMainAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | 
			GtCoderCodeExecutor doItAndGo
				coderUIModel: aCoderUIModel;
				event: anEvent;
				execute ]
		id: GtSourceCoderDoItAndGoActionId."

	addOns
		addMainAction: 'Inspect UI Model' translated
		icon: BrGlamorousVectorIcons inspect
		action: [ :aCoderUIModel :anEvent | self notifyObjectSpawn: aCoderUIModel ].
]
