# 🎯 Quick Reference Guide - Tajir Advanced Features

## 📱 For End Users

### Get Started in 5 Minutes

1. **Initialize Account**
   ```
   POST /api/advanced/paper/account/create
   POST /api/advanced/risk/initialize-limits
   POST /api/advanced/security/legal-acknowledge
   ```

2. **Try Paper Trading**
   ```
   POST /api/advanced/paper/trade/open
   # Trade with live data, no real money
   ```

3. **Get AI Explanation**
   ```
   POST /api/advanced/explain/generate-prediction
   # See detailed reasoning for every trade
   ```

4. **Enable Automation**
   ```
   POST /api/advanced/risk/execute-trade
   # AI trades within your limits
   ```

### Common Commands (NLP)

```
"Buy EUR/USD at 1.1050 with 50 pips stop"
"Sell when RSI < 30"
"Show me bullish predictions"
"Stop all trading"
"What's my account balance?"
```

### Emergency Stop

```
POST /api/advanced/risk/kill-switch
# Everything stops immediately
```

---

## 👨💻 For Developers

### API Base URL
```
http://localhost:8080/api/advanced
```

### Service Endpoints

| Feature | Method | Endpoint | Purpose |
|---------|--------|----------|---------|
| Risk | GET | `/risk/assessment/{user_id}` | Get risk status |
| Risk | POST | `/risk/execute-trade` | Trade with checks |
| Risk | POST | `/risk/kill-switch` | Emergency stop |
| Explain | POST | `/explain/generate-prediction` | Generate explanation |
| Explain | GET | `/explain/history` | Prediction history |
| Exec | POST | `/execution/conditional-order` | Create if-then order |
| Exec | GET | `/execution/session-analysis` | Market session info |
| Security | POST | `/security/api-key/create` | Create API key |
| Security | POST | `/security/legal-acknowledge` | Accept terms |
| Notify | POST | `/notifications/preferences` | Set alert channels |
| Paper | POST | `/paper/account/create` | Create sim account |
| Paper | POST | `/paper/trade/open` | Open sim trade |
| NLP | POST | `/nlp/parse-command` | Parse human command |

### Example Request

```python
import requests

url = "http://localhost:8080/api/advanced/paper/trade/open"
payload = {
    "user_id": "user_123",
    "pair": "EUR/USD",
    "action": "BUY",
    "position_size": 50000,
    "entry_price": 1.1050,
    "stop_loss": 1.1000,
    "take_profit": 1.1150
}
response = requests.post(url, json=payload)
print(response.json())
```

### Error Handling

```python
if response.status_code != 200:
    error = response.json()
    print(f"Error: {error['error']}")
    print(f"Details: {error.get('details')}")
```

---

## 🔑 Key Concepts

### Risk Limits
```json
{
  "max_trade_size": 100000,           // Units per trade
  "daily_loss_limit": 2.0,             // Stop at -2%
  "max_open_positions": 5,             // Max concurrent
  "max_drawdown_percent": 10.0,        // Account drawdown limit
  "mandatory_stop_loss": true,
  "mandatory_take_profit": true
}
```

### Confidence Score
- **90-100%**: Very confident, high convergence
- **75-89%**: Confident, most signals agree
- **60-74%**: Moderate, mixed signals
- **< 60%**: Low confidence, proceed with caution

### Trading Sessions
- **Asian** (22:00-08:00 UTC): Lower volatility
- **London** (08:00-16:00 UTC): Highest volatility
- **New York** (13:00-22:00 UTC): Strong trends
- **Off-hours**: Lower liquidity

### Notifications
- 🔔 Push / 📧 Email / 💬 In-App / 📱 Telegram / 📲 WhatsApp / 📞 SMS

---

## 🎯 Workflow Examples

### Example 1: Complete First Trade

```python
# 1. Setup (one time)
setup_response = requests.post(
    "http://localhost:8080/api/advanced/risk/initialize-limits",
    json={
        "user_id": "john_doe",
        "max_trade_size": 50000,
        "daily_loss_limit": 1.0,
        "max_open_positions": 3,
        "max_drawdown_percent": 5.0
    }
)

# 2. Accept terms (one time)
legal_response = requests.post(
    "http://localhost:8080/api/advanced/security/legal-acknowledge",
    json={
        "user_id": "john_doe",
        "ip_address": "192.168.1.1",
        "risk_disclaimer_accepted": True,
        "trading_losses_understood": True,
        "autonomous_trading_authorized": True,
        "api_key_usage_acknowledged": True,
        "data_privacy_accepted": True,
        "terms_of_service_accepted": True
    }
)

# 3. Test in paper trading
paper_account = requests.post(
    "http://localhost:8080/api/advanced/paper/account/create",
    json={"user_id": "john_doe", "starting_balance": 10000}
)

# 4. Open a paper trade
trade_response = requests.post(
    "http://localhost:8080/api/advanced/paper/trade/open",
    json={
        "user_id": "john_doe",
        "pair": "EUR/USD",
        "action": "BUY",
        "position_size": 50000,
        "entry_price": 1.1050,
        "stop_loss": 1.1000,
        "take_profit": 1.1150
    }
)

# 5. When confident, execute real trade
# (same as paper trade, but uses execute-trade instead)
```

### Example 2: Conditional Order

```python
# Trade EUR/USD only if multiple conditions met
conditional = requests.post(
    "http://localhost:8080/api/advanced/execution/conditional-order",
    json={
        "user_id": "john_doe",
        "pair": "EUR/USD",
        "action": "SELL",
        "conditions": [
            {
                "type": "price_level",
                "operator": "<",
                "value": 30,
                "description": "RSI < 30"
            },
            {
                "type": "indicator_value",
                "operator": "==",
                "value": "bearish",
                "description": "Trend is bearish"
            }
        ],
        "position_size": 50000,
        "stop_loss": 1.1100,
        "take_profit": 1.0950,
        "max_hours": 24,
        "session_filter": "london"
    }
)
```

### Example 3: Natural Language Command

```python
# Let AI understand natural language
nlp_response = requests.post(
    "http://localhost:8080/api/advanced/nlp/parse-command",
    json={"text": "Buy EUR/USD at 1.1050 with 1% stop loss"}
)

# AI response:
{
    "success": True,
    "command_type": "buy_order",
    "confidence": 0.95,
    "ai_response": "✅ Buy order ready! EUR/USD at 1.1050. Stop at 1.1039. Execute?",
    "parameters": {
        "pair": "EUR/USD",
        "action": "BUY",
        "entry_price": 1.1050,
        "stop_loss_percent": 1.0
    }
}
```

---

## 🔒 Security Best Practices

1. **Never Share API Keys**
   ```python
   # ❌ WRONG
   api_key = "super_secret_key_12345"
   requests.post(url, headers={"X-API-Key": api_key})
   
   # ✅ RIGHT
   import os
   api_key = os.environ.get("FOREX_API_KEY")
   ```

2. **Always Use HTTPS in Production**
   ```python
   # ✅ RIGHT
   base_url = "https://api.tajir.com"
   ```

3. **Limit API Key Scope**
   ```python
   # Create trade-only key (not read+write)
   api_key = create_api_key(scope="trade_only")
   ```

4. **Check Audit Logs**
   ```python
   audit_logs = requests.get(
       "http://localhost:8080/api/advanced/security/audit-log/user_123"
   )
   ```

---

## 📊 Monitoring & Analytics

### Get Account Status
```python
status = requests.get(
    "http://localhost:8080/api/advanced/risk/assessment/user_123"
).json()

print(f"Risk Level: {status['risk_level']}")
print(f"Open Positions: {status['current_status']['open_positions']}")
print(f"Daily P&L: {status['current_status']['daily_profit_loss']}%")
```

### Get Trading Analytics
```python
analytics = requests.get(
    "http://localhost:8080/api/advanced/risk/analytics/user_123?days=30"
).json()

print(f"Total Trades: {analytics['summary']['total_trades']}")
print(f"Win Rate: {analytics['summary']['win_rate']}%")
print(f"Total P&L: {analytics['summary']['total_profit_loss']}")
```

### Get Prediction Accuracy
```python
accuracy = requests.get(
    "http://localhost:8080/api/advanced/explain/accuracy-report"
).json()

print(f"Win Rate: {accuracy['summary']['win_rate']}")
print(f"Most Accurate Pair: {max_pair}")
```

---

## ⚙️ Configuration Templates

### Conservative Setup
```json
{
  "max_trade_size": 10000,
  "daily_loss_limit": 1.0,
  "max_open_positions": 2,
  "max_drawdown_percent": 3.0,
  "notifications": ["PUSH", "EMAIL"],
  "quiet_hours": "22:00-08:00"
}
```

### Aggressive Setup
```json
{
  "max_trade_size": 100000,
  "daily_loss_limit": 5.0,
  "max_open_positions": 10,
  "max_drawdown_percent": 15.0,
  "notifications": ["PUSH"],
  "quiet_hours": "none"
}
```

### Paper Trading Setup
```json
{
  "starting_balance": 10000,
  "pairs": ["EUR/USD", "GBP/USD", "USD/JPY"],
  "test_duration": "14_days",
  "min_trades": 20,
  "min_win_rate": 55
}
```

---

## 🆘 Troubleshooting

### "Trade validation failed"
- Check daily loss limit not exceeded
- Verify stop loss is set (if mandatory)
- Ensure position size < max_trade_size
- Check open positions < max_open_positions

### "NLP confidence too low"
- Be more specific in command
- Use example commands from `/nlp/examples`
- Try structured API call instead

### "Conditional order not triggering"
- Check conditions are correct
- Verify session filter matches current time
- Check order hasn't expired (max_hours)
- Confirm market is trading the pair

### "Kill switch won't activate"
- Ensure you have permission to activate
- Check API key scope includes this operation
- Verify kill switch isn't already active

---

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| `ADVANCED_FEATURES_GUIDE.md` | Complete feature documentation |
| `IMPLEMENTATION_COMPLETE_v3.md` | Implementation summary |
| This file | Quick reference |

---

## 🔗 Useful Links

- **API Docs**: `http://localhost:8080/docs` (Swagger)
- **Health Check**: `http://localhost:8080/api/advanced/health`
- **Copilot Status**: `http://localhost:8080/api/advanced/copilot/status/{user_id}`
- **Paper Guide**: `http://localhost:8080/api/advanced/paper/guide`
- **Command Examples**: `http://localhost:8080/api/advanced/nlp/examples`

---

## 💡 Pro Tips

1. **Start with Paper Trading**: Build confidence first
2. **Use Conditional Orders**: Automate intelligently
3. **Monitor Accuracy**: Track which signals work best
4. **Set Risk Limits**: Sleep better at night
5. **Check Audit Logs**: Compliance and learning
6. **Use NLP Commands**: Make it feel conversational
7. **Rotate API Keys**: Security best practice
8. **Review Explanations**: Understand the "why"

---

## 🎓 Learning Path

```
Day 1: Setup & Paper Trading
  └─ Explore the dashboard
  └─ Try 5 paper trades
  └─ Review explanations

Day 2-7: Understanding
  └─ Study prediction accuracy
  └─ Learn about sessions
  └─ Practice NLP commands

Week 2: Mastery
  └─ Create conditional orders
  └─ Optimize risk limits
  └─ Monitor analytics

Week 3+: Production
  └─ Enable real trading
  └─ Increase position sizes gradually
  └─ Use all features confidently
```

---

## 🚀 You're Ready!

Everything is set up and ready to use. Start with paper trading and gradually work your way up to real trading. Remember:

- **AI handles decisions** ← but within your limits
- **You handle control** ← kill switch always available  
- **Transparency is key** ← AI explains everything
- **Safety first** ← built into every feature

**Happy autonomous trading! 📈**

---

*Last Updated: January 22, 2026*  
*Tajir v3.0.0 - Your AI Trading Copilot*
