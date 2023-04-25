package com.example.benefit_test

import android.content.ContentValues
import android.content.Intent
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import mobi.foo.benefitinapp.data.Transaction
import mobi.foo.benefitinapp.listener.BenefitInAppButtonListener
import mobi.foo.benefitinapp.listener.CheckoutListener
import mobi.foo.benefitinapp.utils.BenefitInAppButton
import mobi.foo.benefitinapp.utils.BenefitInAppCheckout
import mobi.foo.benefitinapp.utils.BenefitInAppHelper

class MainActivity: FlutterActivity() {

    private val channel = "ummatisoftwares.benefitpay"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
                call, result ->
            if (call.method == "BenefitPay"){
                val amount = call.argument<String>("amount")
                val referenceId = call.argument<String>("reference")
               checkOut(amount.toString(), referenceId.toString(), result)
            } else {
                result.notImplemented()
            }
        }

    }

    private fun checkOut(paymentAmount: String, reference:String, result: MethodChannel.Result) {
        val button = BenefitInAppButton(this@MainActivity)
        button.setListener(object: BenefitInAppButtonListener {
            override fun onButtonClicked() {
                val benefitInAppCheckout = BenefitInAppCheckout.newInstance(
                    this@MainActivity,
                    "3253656030",
                    reference,
                    "004957102",
                    "4nt1zva9cb61ru59mbms5lole719b5a57a79fxpnt9ad9",
                    paymentAmount,
                    "BH",
                    "048",
                    "4215",
                    "DELIVER X",
                    "Manama",
                    (object : CheckoutListener {
                        override fun onTransactionSuccess(p0: Transaction?) {
                            if (p0 != null){
                                Log.i(ContentValues.TAG, " "+p0.amount)
                                Log.i(ContentValues.TAG, " "+p0.merchantId)
                                Log.i(ContentValues.TAG, " "+p0.merchant)
                                Log.i(ContentValues.TAG, " "+p0.referenceNumber)
                                Log.i(ContentValues.TAG, " "+p0.terminalId)
                                Log.i(ContentValues.TAG, " "+p0.currency)
                                Log.i(ContentValues.TAG, " "+p0.cardNumber)
                                Log.i(ContentValues.TAG, " "+p0.transactionMessage)
                            }
                            Log.i(ContentValues.TAG, "Hamad Pass")
                            Toast.makeText(applicationContext, "Success", Toast.LENGTH_LONG).show()
                            result.success("Success")
                        }

                        override fun onTransactionFail(p0: Transaction?) {
                            if (p0 != null){
                                Log.i(ContentValues.TAG, " "+p0.amount)
                                Log.i(ContentValues.TAG, " "+p0.merchantId)
                                Log.i(ContentValues.TAG, " "+p0.merchant)
                                Log.i(ContentValues.TAG, " "+p0.referenceNumber)
                                Log.i(ContentValues.TAG, " "+p0.terminalId)
                                Log.i(ContentValues.TAG, " "+p0.currency)
                                Log.i(ContentValues.TAG, " "+p0.cardNumber)
                                Log.i(ContentValues.TAG, " "+p0.transactionMessage)
                            }
                            Log.i(ContentValues.TAG, "Hamad Fail")
                            Toast.makeText(applicationContext, "Fail", Toast.LENGTH_LONG).show()
                            result.error("Fail", p0.toString(), null)
                        }

                    })
                )
            }

            override fun onFail(p0: Int) {
                result.error(p0.toString(), "Check params error", null)
            }

        })
        button.performClick()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (resultCode == RESULT_OK) {
            Log.i(ContentValues.TAG, "Hamad result")
            BenefitInAppHelper.handleResult(data)
        } else {
        }
    }
}
