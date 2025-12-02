Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
CompiledMethod >> gtNavigationOverridenIndicatorActionFor: anAction [
	<gtAction>
	^ anAction explicit
		target: GtCoderNavigationMethodTarget;
		stencil: [ 
			"We reuse already existing widget that requires a method coder view model."
			GtPharoMethodCoderOverridingOverriddenElement new
				pharoMethodCoderViewModel: (GtPharoMethodCoder forMethod: self) asCoderViewModel ]
]
