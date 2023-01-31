Extension { #name : #GtSmaCCDiffSplitter }

{ #category : #'*GToolkit-Pharo-Coder' }
GtSmaCCDiffSplitter classSide >> forPharo [
	^ self new scannerClass: GtPharoScanner
]
