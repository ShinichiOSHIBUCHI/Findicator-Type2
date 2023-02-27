package com.example.findicator

//import android.util.Log;

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import androidx.appcompat.app.AppCompatActivity

import com.fasterxml.jackson.databind.ObjectMapper

import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StandardMessageCodec
import jp.co.ise.worktransform.aisuccessionaylib.iflink.AISuccessionaryBridge
import jp.co.ise.worktransform.aisuccessionaylib.Constants
import java.util.ArrayList
import java.util.HashMap


class MainActivity: FlutterActivity() {
    private val channelName = "samples.flutter.dev/counter"
    private var counter: Int = 1
    override protected fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // レシーバーの初期化
        //initBroadcastReceiver(receiver)
    }
    private val receiver: BroadcastReceiver? = null
    protected fun initBroadcastReceiver(receiver: BroadcastReceiver?, channel : BasicMessageChannel<Any?>) {
        var receiver: BroadcastReceiver? = receiver

        receiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent) {
                val action = intent.getAction()
                if (Constants.ACTION_RECEIVED_DATA_ACTIVITY.equals(action)) {

                    // 受け取ったjsonからRecommendの情報を取得
                    val recommends = intent.getStringExtra(Constants.EXTRA_VALUE_DATA_ITEM)
                    channel.send(mapOf("name" to recommends, "counter" to counter++))
                    recommends?.let{Log.i("test", recommends)}
                }
            }
        }
        registerReceiver(receiver, makeIntentFilter())
    }
    private fun makeIntentFilter(): IntentFilter? {
        val intentFilter = IntentFilter()
        intentFilter.addAction(Constants.ACTION_RECEIVED_DATA_ACTIVITY)
        return intentFilter
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val channel : BasicMessageChannel<Any?> = BasicMessageChannel<Any?>(flutterEngine.dartExecutor.binaryMessenger, channelName, StandardMessageCodec())
        val handler : MyMessageHandler = MyMessageHandler(channel, this)
        channel.setMessageHandler(handler)
        initBroadcastReceiver(receiver, channel)
    }
}

class MyMessageHandler constructor (val channel : BasicMessageChannel<Any?>, val context:Context) : BasicMessageChannel.MessageHandler<Any?> {
    private val handler = Handler(Looper.getMainLooper())

    private var counter: Int = 1
    private val runnable: Runnable = object : Runnable {
        override fun run() {
            //sendMsgToFlutter()
        }
    }

    init {
        handler.post(runnable)
    }

    //Flutterへのメッセージ送信ハンドリング
    fun sendMsgToFlutter() {
        channel.send(getCounter()) { reply ->
            Log.d("Android", "$reply")
        }
        handler.postDelayed(runnable, 4000)
    }

    private fun getCounter() : Map<String, Any> {
        return mapOf("name" to "TEST", "counter" to counter++)
    }

    // Flutter側からのメッセージのハンドリング
    override fun onMessage(message: Any?, reply: BasicMessageChannel.Reply<Any?>) {
        val name = (message as Map<String, Any>)["name"]
        val message = (message as Map<String, Any>)["message"]
        Log.d("Android", "<Msg From Flutter> = Name:$name, Counter:$message")
        reply.reply("Hey, $name! Your counter is : $message")
        sendMessage(message.toString())
    }

    protected fun sendMessage(data: String?) {
        // 状況データのjsonを作成の上、処理を実行する
        val bridge = AISuccessionaryBridge()
        //val base64String = "ここに画像のbase64エンコード文字列"
        val base64String = data
        val om = ObjectMapper()
        val json: HashMap<String, MutableList<HashMap<String, String?>>> = HashMap()
        json["data"] = ArrayList()
        json["data"]!!.add(HashMap())
        json["data"]!![0]["type"] = "image"
        json["data"]!![0]["data"] = base64String
        try {
            bridge.GetRecommendsFromScene(context, om.writeValueAsString(json))
            Log.d("Android", "<Send json data = json:$json")
        } catch (e: Exception) {
        }
    }
}