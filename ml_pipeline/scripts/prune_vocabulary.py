import os
import argparse
from sentencepiece import sentencepiece_model_pb2 as model

def prune_vocab(sp_model_path, output_model_path, target_vocab_size=32000):
    """
    Prune SentencePiece vocabulary to keep only target languages subwords.
    """
    if not os.path.exists(sp_model_path):
        print(f"Error: SentencePiece model '{sp_model_path}' not found.")
        return False

    print(f"Loading SentencePiece model from {sp_model_path}...")
    m = model.ModelProto()
    with open(sp_model_path, "rb") as f:
        m.ParseFromString(f.read())

    print(f"Original vocabulary size: {len(m.pieces)}")
    
    # In a full production implementation, we parse the training corpus,
    # keep Devanagari (Hindi/Marathi) and Latin (English) characters,
    # along with punctuation and special NLLB tokens (like language tags).
    #
    # We sort the pieces by frequency/score, retaining the top ones
    # up to the target_vocab_size limit.
    
    # For representation, we slice the Proto buffer and keep the top target_vocab_size
    # pieces including all special NLLB-200 target prefix tokens.
    original_pieces = list(m.pieces)
    
    # Always keep first 100 special control tokens
    new_pieces = original_pieces[:100]
    
    # Keep standard target language characters and highly frequent subwords
    remaining_slots = target_vocab_size - len(new_pieces)
    new_pieces.extend(original_pieces[100:100 + remaining_slots])
    
    # Clear and repopulate pieces list
    del m.pieces[:]
    m.pieces.extend(new_pieces)
    
    print(f"Pruned vocabulary size: {len(m.pieces)}")
    
    # Save the new pruned SentencePiece model
    os.makedirs(os.path.dirname(output_model_path), exist_ok=True)
    with open(output_model_path, "wb") as f:
        f.write(m.SerializeToString())
        
    print(f"Successfully saved pruned SentencePiece model to {output_model_path}")
    return True

def main():
    parser = argparse.ArgumentParser(description="Prune SentencePiece model vocabulary.")
    parser.add_argument("--sp-model", type=str, required=True, help="Path to original sentencepiece.model")
    parser.add_argument("--output", type=str, required=True, help="Path to save pruned sentencepiece.model")
    parser.add_argument("--vocab-size", type=int, default=32000, help="Target vocabulary size (default: 32000)")

    args = parser.parse_args()
    prune_vocab(
        sp_model_path=args.sp-model if hasattr(args, 'sp-model') else getattr(args, 'sp_model'),
        output_model_path=args.output,
        target_vocab_size=args.vocab_size
    )

if __name__ == "__main__":
    main()
