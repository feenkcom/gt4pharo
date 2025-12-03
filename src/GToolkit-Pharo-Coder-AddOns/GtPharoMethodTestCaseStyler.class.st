"
I am a {{gtClass:GtGenericPharoStyler}}.
I insert {{gtClass:GtPharoMethodTestCaseStateAttribute}} into a {{gtClass:BlText}}. 

"
Class {
	#name : #GtPharoMethodTestCaseStyler,
	#superclass : #GtGenericPharoStyler,
	#category : 'GToolkit-Pharo-Coder-AddOns-Example status'
}

{ #category : #generated }
GtPharoMethodTestCaseStyler >> visitMethod: aMethodNode [
	| aTestCase |

	aTestCase := self coderViewModel coderModel testCase.
	aTestCase canExecute ifFalse: [ ^ self ].
	
	self
		attribute: (GtPharoMethodTestCaseStateAttribute new testCase: aTestCase)
		from: aMethodNode pattern stopPosition
		to: aMethodNode pattern stopPosition
]
