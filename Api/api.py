from flask import Flask, jsonify ,request
from sumy.parsers.plaintext import PlaintextParser
from sumy.nlp.tokenizers import Tokenizer
from sumy.summarizers.text_rank import TextRankSummarizer


# summery
def summeryText(text):
    parser = PlaintextParser.from_string(text,Tokenizer("arabic"))
    summarizer_4 = TextRankSummarizer()
    summary =summarizer_4(parser.document , 10)
    text_summary=""
    for sentence in summary:
        text_summary+=str(sentence)
    return text_summary

app = Flask(__name__)

@app.route('/example_endpoint')
def example_endpoint():
    title = request.args.get('parameter_name')
    final_text = summeryText(title)
    data = {"data": final_text}
    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0' , port=5000)


#"http://192.168.1.3:5000/example_endpoint?parameter_name=$text";




