package com.idir.barcodescanner.infrastructure.barcode

import com.idir.barcodescanner.infrastructure.barcode.commands.ICommand

class BarcodeBroadcaster : IBarcodeBroadcaster {
    private val subscribers : MutableList<IBarcodeSubscriber> = mutableListOf()
    private val onNotifyCommands : MutableList<ICommand> = mutableListOf()


    override fun notifyBarcode(rawBarcode: String) {
        onNotifyCommands.forEach { it.execute() }
        subscribers.forEach {
                subscriber -> subscriber.notify(rawBarcode)
        }
    }

    override fun notifyBarcodes(rawBarcodes: List<String>) {
        onNotifyCommands.forEach { it.execute() }
        subscribers.forEach {
                subscriber -> subscriber.notify(rawBarcodes)
        }
    }

    override fun subscribeToBarcodeStream(subscriber : IBarcodeSubscriber) {
        subscribers.add(subscriber)
    }

    override fun unsubscribeFromBarcodeStream(subscriber: IBarcodeSubscriber) {
        subscribers.remove(subscriber)
    }

    override fun registerOnNotifyCommand(command: ICommand) {
        onNotifyCommands.add(command)
    }

    override fun unregisterOnNotifyCommand(command: ICommand) {
        onNotifyCommands.remove(command)
    }


}